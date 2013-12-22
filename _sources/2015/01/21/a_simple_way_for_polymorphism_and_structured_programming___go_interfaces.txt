A simple way for polymorphism and structured programming - Go interfaces
========================================================================

.. author:: default
.. categories:: programming
.. tags:: go
.. comments::

On 2015-01-08 I was presenting different polymorphism methods at `Institute of Computer Science  University of Wrocław <http://ii.uni.wroc.pl/en>`_. I'm a big fan of simplicity in IT.
During that presentation I was trying to persuade why we need simplicity in IT: both for maintenance and high quality software.
One of the most important programming language feature to make a program source code more conscious is *polymorphism*.

Polymorphism is a very broad term. It can mean anything from having different shapes to sharing some functionality. It can be very powerful (eg `Haskell <http://haskell.org/>`_, `Agda <http://en.wikipedia.org/wiki/Agda_%28programming_language%29>`_), mean (`C <http://en.wikipedia.org/wiki/C_%28programming_language%29>`_), flexible / dynamic (`Python <http://python.org>`_) or powerful-obscured (`Scala <http://scala-lang.org/>`_). There are hundreds of features researches are implementing in theirs programming languages. However, It's a difficult art to select a minimum set of features which will bring simplicity and productivity.

My lecture leads to one language which accomplish that art pretty well: `Go <http://golang.org/>`_.
It still lacks few features to get a really good productivity (eg *genetics*, however thanks to `go generate <http://golang.org/s/go1.4-generate>`_ we have some workaround).

I'm calling this achievement **Zen of Go**: it provides a minimal, basic syntax and constructs in a spirit of `Zen of Python <https://www.python.org/dev/peps/pep-0020/>`_, powerful runtime with build-in coroutine scheduler (in Go we call them goroutines), convenient structures for parallelism and static typing - just to name few of them. What's really important the language is minimalist - check the `Go lang spec <http://golang.org/ref/spec>`_ and try to compare it to any other popular language.

All in all, the overall result is remarkable. There are thousands of blog posts about Go, both positive and negatives (in my opinion people who present Go in a bad shape either didn't use Go or they use it in a wrong domain - think about using assembler in web programming). One is sure: a lot of companies are migrating their software to Go (with Google in the first place). Recently, with 1.4 release `Go become first class language on Android <http://vimeo.com/115307069>`_. Companies are happily sharing `success stories <http://blog.gopheracademy.com/birthday-bash-2014/go-turns-5/>`_. This proves that decisions for simplicity and a dynamic (*weak*) polymorphism (which is the usual wart in the *negative* go related articles) are working well for big projects.
Personally I'm using Go in production since the end of 2012 and I'm very happy for it. It doesn't fit well for all domains I'm working in (eg. for data mining environments like matlab or lua-torch are better situated) - but as always, let's use the right tool for the job.

Please enjoy my presentation:


.. raw:: html

	<iframe src="http://www.slideshare.net/slideshow/embed_code/43759232" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen="true"> </iframe> <div style="margin-bottom:5px"> <a href="http://www.slideshare.net/robertzaremba/go-polymorphism" title="A simple way for polymorphism and structured programming - Go interfaces" target="_blank">A simple way for polymorphism and structured programming - Go interfaces</a>.</div>


Bottom line after presentation @ii
----------------------------------

During the presentation there was a weird guy who was suggesting that Rob Pike will kill for not using go.talks (he even didn't know a name of the tool). I'm still alive!
