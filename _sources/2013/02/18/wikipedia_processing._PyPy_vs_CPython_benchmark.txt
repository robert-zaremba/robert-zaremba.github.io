Wikipedia processing. PyPy vs CPython benchmark
===============================================

.. author:: default
.. categories:: programming
.. tags:: Python, PyPy
.. comments::

Lately I've done some data mining tasks on Wikipedia. It consist of:

* processing enwiki-pages-articles.xml Wikipedia dump
* storing pages and categories into mongodb
* using redis for mapping category titles

I made a benchmark on a real tasks for CPython 2.7.3 and PyPy 2b. Libraries I used:

* redis 2.7.2
* pymongo 2.4.2

Furthermore CPython was supported by:

* hiredis
* pymongo c-extensions

The benchmark mostly involve databases processing so I fought I won't have huge PyPy benefit (since CPython drivers are supported by *C-extensions*).

Below I will describe some interesting results

.. more::

Extracting pagenames
####################

I needed to make `pagenames <http://en.wikipedia.org/wiki/Wikipedia:Page_name>`_ to ``page.id`` mapping of all categories from Wikipedia and store them in redis. The simplest solution would be to import *enwiki-page.sql* (which defines a RDB table) into MySQL and then transport them to redis. But I didn't want to add MySQL requirements so I wrote a simple SQL *insert expression* parser in pure Python and directly import data from *enwiki-page.sql* to redis.

This task is more CPU hungry so we expect PyPy gain.

=======  =====================================
 /       time
=======  =====================================
PyPy     169.00s user   8.52s system 90% cpu
CPython  1287.13s user   8.10s system 96% cpu
=======  =====================================

I also made similar mapping for ``page.id -> categories`` using *enwiki-categorylinks.sql* in Mongodb (the capacity of RAM on my laptop is too small to hold informations I need).


Filtering categories from enwiki.xml
####################################

To facilitate work with categories I needed to filter categories from *enwiki-pages-articles.xml* and store them back with the same xml format.
For this task I used SAX parser, which in both PyPy and CPython is a wrapper around ``expat`` parser. ``expat`` is native complied package (in both PyPy and CPython).

The code is quiet simple::

    class WikiCategoryHandler(handler.ContentHandler):
        """Class which detecs category pages and stores them separately
        """
        ignored = set(('contributor', 'comment', 'meta'))

        def __init__(self, f_out):
            handler.ContentHandler.__init__(self)
            self.f_out = f_out
            self.curr_page = None
            self.curr_tag = ''
            self.curr_elem = Element('root', {})
            self.root = self.curr_elem
            self.stack = Stack()
            self.stack.push(self.curr_elem)
            self.skip = 0

        def startElement(self, name, attrs):
            if self.skip>0 or name in self.ignored:
                self.skip += 1
                return
            self.curr_tag = name
            elem = Element(name, attrs)
            if name == 'page':
                elem.ns = -1
                self.curr_page = elem
            else:   # we don't want to keep old pages in memory
                self.curr_elem.append(elem)
            self.stack.push(elem)
            self.curr_elem = elem

        def endElement(self, name):
            if self.skip>0:
                self.skip -= 1
                return
            if name == 'page':
                self.task()
                self.curr_page = None
            self.stack.pop()
            self.curr_elem = self.stack.top()
            self.curr_tag = self.curr_elem.tag

        def characters(self, content):
            if content.isspace(): return
            if self.skip == 0:
                self.curr_elem.append(TextElement(content))
                if self.curr_tag == 'ns':
                    self.curr_page.ns = int(content)

        def startDocument(self):
            self.f_out.write("<root>\n")

        def endDocument(self):
            self.f_out.write("<\root>\n")
            print("FINISH PROCESSING WIKIPEDIA")

        def task(self):
            if self.curr_page.ns == 14:
                self.f_out.write(self.curr_page.render())


    class Element(object):
        def __init__(self, tag, attrs):
            self.tag = tag
            self.attrs = attrs
            self.childrens = []
            self.append = self.childrens.append

        def __repr__(self):
            return "Element {}".format(self.tag)

        def render(self, margin=0):
            if not self.childrens:
                return u"{0}<{1}{2} />".format(
                    " "*margin,
                    self.tag,
                    "".join([' {}="{}"'.format(k,v) for k,v in {}.iteritems()]))
            if isinstance(self.childrens[0], TextElement) and len(self.childrens)==1:
                return u"{0}<{1}{2}>{3}</{1}>".format(
                    " "*margin,
                    self.tag,
                    "".join([u' {}="{}"'.format(k,v) for k,v in {}.iteritems()]),
                    self.childrens[0].render())

            return u"{0}<{1}{2}>\n{3}\n{0}</{1}>".format(
                " "*margin,
                self.tag,
                "".join([u' {}="{}"'.format(k,v) for k,v in {}.iteritems()]),
                "\n".join((c.render(margin+2) for c in self.childrens)))

    class TextElement(object):
        def __init__(self, content):
            self.content = content

        def __repr__(self):
            return "TextElement"

        def render(self, margin=0):
            return self.content




The ``Element`` and ``TextElement`` objects holds information about element tag and body, and provides a method to render it.

Here I expect similar result for both PyPy and CPython.

=======  ========
  /      time
=======  ========
PyPy     2169.90s
CPython  4494.69s
=======  ========

I'm positively surprised with PyPy result.


Computing interesting categories set
####################################

I wanted to compute a interesting categories set - which, in my use case, consist of categories derived from *Computing* category.
For this I needed to construct a category graph which will provide *category - sub categories* relation.

Construction category - sub categories relation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This task uses data from mongodb and redis constructed before. The algorithms is::

    for each category.id in redis_categories (it holds *category.id -> category title mapping*) do:
        title = redis_categories.get(category.id)
        parent_categories = mongodb get categories for title
        for each parent_cat in parent categories do:
            redis_tree.sadd(parent_cat, title) # add to parent_cat set title

Sorry for this pseudo code, but I think it looks more compact.

So this task is just copying data between databases. The result here are made after mongodb warming up (without it the results are biased because mongodb latency - the python job uses only 10% CPU) The timing is:

=======  ========
  /      time
=======  ========
PyPy     175.11s user 66.11s system 64% cpu
CPython  457.92s user 72.86s system 81% cpu
=======  ========

Another points to PyPy.

Traversing redis_tree
^^^^^^^^^^^^^^^^^^^^^

If we have ``redis_tree`` database, then only thing left is to traverse all nodes which are achievable from *Computing* category.
To preserve falling into cycle we need to remember which categories we visited. Since I want to test Python for database tasks I used redis set field for this.

=======  ========
  /      time
=======  ========
PyPy     14.79s user  6.22s system 69% cpu 30.322 total
CPython  44.20s user 13.86s system 71% cpu 1:20.91 total
=======  ========

To be honest this task also requires constructing some *tabu list* - to prevent jumping into unwanted categories. But this is not a point of this article.

Conclusions
###########

Presented tasks are only introduction for my final work. It requires a knowledge base which I got by extracting appropriate articles from Wikipedia.

PyPy gives me 2-3 times performance boost compared to CPython for simple data bases operations (I'm not counting sql parser here, which is almost 8x).

Thanks PyPy my work was more pleasant - I got Python productivity without frustrating with waiting for results to correct my algorithms. Moreover PyPy doesn't kill my CPU as CPython does so in a meantime I could normally use my laptop (check % CPU time usage).

The tasks was mostly database manipulation, and CPython has some speed-up from developers contribute into dirty *C-extensions*. PyPy doesn't use them and at the end is faster!

All my work required a lot of cycles so I'm really happy with PyPy.
