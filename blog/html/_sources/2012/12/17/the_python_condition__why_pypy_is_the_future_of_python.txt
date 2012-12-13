The Python condition. Why PyPy is the future of Python
======================================================

.. author:: default
.. categories:: IT
.. tags:: Python, PyPy
.. comments::

.. |br| raw:: html

    <br />


Python - the language
#####################

Python is now far more then simply glue or scripting language. For those who think otherwise just check the couple of Python success stories:

* YouTube - it's mainly written in Python
* `NASA <http://python.org/about/success/usa/>`_
* `Industrial Light & Magic Runs <http://python.org/about/success/ilm/>`_ - the movie company
* `OpenStack <https://en.wikipedia.org/wiki/OpenStack>`_
* `Sage <http://www.sagemath.org/>`_ - the scientific software, and others (SciPy, PythonXY)
* Web programming using Django, Pyramid, bottle...
* Revision Control System
* `all other great software <http://en.wikipedia.org/wiki/List_of_Python_software#Applications>`_

I recommend `My-Favorite-Python-Things <http://www.infoq.com/presentations/A-Few-of-My-Favorite-Python-Things>`_ presentation if you are looking for a quick intro to the beauty of Python.

High level languages are mainstream
###################################

Nowadays high level languages allow to write simple code with greater flexibility.
Creating applications faster makes people choosing dynamic languages, where you don't need to specify types and waste time to fighting with them (all the boilerplate code about interfaces just to satisfy compilation process).
Someone can argue that this behaviour produces buggy code. For those I would say, after Guido van Rossum: "*who produces code without test*"? Static languages can handle some errors during compile time. But they can't detect all of them. So in the end you need to write tests, which in the same time are sufficient to test typing and easier to write using dynamic languages.
Moreover people still can't invent good (far to say perfect) type system. Jim Treavor wrote some `summary <http://trevorjim.com/dynamic-languages/>`_ about this.

New techniques and knowledge allows us to produce highly efficient runtimes for dynamic languages (JavaScript V8, LuaJIT, Racket, Common Lisp...), which successfully compete with tremendous software frameworks (JVM, .NET, ...)

All of this makes high level languages increasingly popular in enterprises and daily use.

Is Python continue the success story?
*************************************

Now, Python is very popular. But it's position is threatened by a competition.
Python has a great ecosystem with huge amount of software and community.
But it lacks efficient and state of the art runtime, which competition already have.


Python as a glue language.
**************************

As I stayed at the begging one of the features which contribute to Python success is its ability to easily connect to compiled libraries, which makes it perfect as a glue language. But this made Python popular 20 years ago. The tools, which are still popular, are old. The problem with them is you need to make quite a lot of effort to use them:

* `ctypes <http://docs.python.org/3.3/library/ctypes.html>`_
* `c extensions <http://docs.python.org/3.3/extending/>`_
* `Cython <http://cython.org/>`_ - It's designed to easily writing *c extensions* and it's good for this task. But I admint that using *c extensions* is a last thing you want to do. There are better ways (more elaboration below). Cython is an external tool which requires compilation process. It produces non dynamic behaviour in a final code and another syntax to learn. In the end Cython doesn't support type inference. The problem with Cython is that when you use it you are done - you have no option than compile it. Cython is not a standard. It can't be used as an interpreted code. Great summary was done by Kay Hayen, the _nuitka_ creator, in `Static Compilation - That is the point <http://nuitka.net/posts/static-compilation-that-is-the-point.html>`_ post.
* `swig <http://www.swig.org/tutorial.html>`_, `boost <http://www.boost.org/doc/libs/1_52_0/libs/python/doc/tutorial/doc/html/index.html>`_  - those are quiet easy, usually requires some changes in C/C++ code, or write some schema file.

In contrast there are new tools which handle this task far more better preserving performance (even outperforming it):

* `cffi <http://cffi.readthedocs.org/en/latest/>`_ - package which allows easily handling your C libraries. You often need to do it while touching a hardware or supporting some other software (like database clients/drivers). Just check how easy is to use it with Python. You don't need to write any wrapper, typed code. Moreover has CPython and PyPy support.
* `bitey <https://github.com/dabeaz/bitey/>`_


Python as a brain of your code - other aspect of a glue language
----------------------------------------------------------------

There is also other aspect of a *glue language*. Let's think about process of low level high performance programming. It probably looks similar to the following process:

* idea
* lot of complicated low level and organization code. Probably in C++ with a bunch of obscure template code (for re usability)
* writing glue code
* compilation
* running
* probably a lot of debugging and return back to writing, because of the amount of low level code.

Thanks Python's portability, scripting nature and big amount of tools, it is used as a template and brain engine for your code.
That means you only write the smallest amount of required low level code, and python do the rest: generating the organization code, and the context required for your low level code.

This takes back to Lisp idea, where code is a data, and makes sense of code about other code that is executed (*code as a data to process*). So the machine can think about what is executing in runtime, then optimizing it, reasoning about full data information in true generic way without templating you known from C++. This is what C++ and other popular languages lost.
At the end we have lower abstraction level but stronger runtime knowledge which allows compiler for:

* Specialize for unknown hardware (at code writing time), the problem with supported types, and available optimizations.
* Automated tuning (e.g. your data for libraries like ATLAS...)
* Allow so put other information to compiler which far more reasoning.
* People don't struggle with data types (Runtime allows to makes it fast, appropriate and... already done)

So the process looks like:

* idea
* little of Python code (the pretty one) - for organization, and low level code - also much nicer because without the rubbish template and context code. Actually low level code can be generated from python code.
* running
* debugging, but much less times then in previous process.

In terms of performance it gives a **better potential** then previous approach.

Examples which already use it: PyPy, cffi, PyOpenCL, PyCUDA, numba, theano...


Python as a fast language
**************************

There are a lot of ways to write a fast code with python.
The most popular and unfortunately still propagated is to write the *hot* parts of application in a low level language and then use.

All the python shining efficient tools requires a lot of complicated c code, which block other contributors to come in.
Now we would like to write fast and beauty python code.

There are a lot of tools to compile a code python to machine code: Nuitka, Python2C, Shedskin, pythran. In my opinion they fail because when you use them you need to say goodbye for dynamic behaviour of the code. They support only a subset of the python language and they are far far away to support it completely. I even don't believe they will. Besides they don't use state of the art techniques and runtime information which makes JITs solutions shining.


Multicore Programming
#####################

Can't write anything better to present the issue then Armins Rigo `Multicore Programming in PyPy and CPython <http://morepypy.blogspot.com/2012/08/multicore-programming-in-pypy-and.html>`_


Interpreter Design.
###################

To make further development easy and implement state of the art techniques for dynamic languages Python needs suitable implementation with well advised architecture. Current CPython architecture is limited because of its simplicity. It makes hard to do things like  JIT compiler. Just check fails of some attempts to enhance CPython interpreter:

* psyco (was abandoned in favour of PyPy)
* Unladen swallow
* a lot of fails with removing GIL
* There are forks which tries repairs some flaws in CPython: Stackless and HotPy, but firmness of Guido (the Benevolent Dictator for Life in Python) hardly stops to merge those projects. (To be clear HotPy is not yet production ready).

One of the biggest drawback of sticking to closely with CPython is it's C API - which is not well designed. Other implementations suffer because of that.

What can we do?
***************

#. Promote new tools for glue code ( **cffi**, **bitey**)
#. Stop rely on low level properties of CPython (C API, c extensions) for common libraries. Instead use some intermediate tools which can handle this:
  * *cffi*   - to easily use C libraries
  * *cython* - to write portable c extensions. I don't recommend it for general programming, but still it's better and easier to maintain then c extensions. Cython already has both CPython and PyPy backend.


Why PyPy is the future?
***********************

PyPy provides much better architecture for optimization and further language development. PyPy already comes with the solution for most of the Pythons issues:

* state of the art runtime and design described in `The Architecture of Open Source Applications <http://www.aosabook.org/en/pypy.html>`_.
* speed - PyPy buildin JIT shines. Sometime (actually rarely) can bit even C!
* GIL issue - PyPy is coming with great STM implementation, which is already mentioned in Armins Rigo `article <http://morepypy.blogspot.com/2012/08/multicore-programming-in-pypy-and.html>`_.
* glue code - easy handling c libraries with cffi, which is even faster than ctypes in CPython!
* asynchronous programming. PyPy has build in greenlets which are better suited in, then the original c extension for CPython. In fact Further development of stackless concept (and thus greenlets) are going to PyPy (check https://ep2012.europython.eu/conference/talks/the-story-of-stackless-python)
* sandboxing
* using in web and mobile. Dusty makes some post about this in `Pushing Python Past the Present <http://archlinux.me/dusty/2012/10/04/pushing-python-past-the-present/>`_

PyPy already has support for multiple platforms (x86, 64_x86, ARM)

PyPy also offers a great, modern architecture which is well described in `Jim Huang presentation <http://www.slideshare.net/jserv/pypy-dynamic-language-compilation-framework>`_
The key points are:

* framework for interpreted languages
* compound of components for research and production (different data models, garbage collectors - can be changed for specific use)
* build on top of functional architecture with chained components (translation toolchains). Each step extends/transforms the program model, introduces features, backends (JVM, JavaScript, LLVM, GCC IR...). Examples of translations: *python code -> bytecode -> function objects -> type inference -> garbage collector -> JIT*
* includes a lot of modern optimization techniques developed on different level of architecture (allows to simplify this task)

I believe that making all software to cooperate with PyPy is a huge effort - it requires a lot of work in existing libraries. But producing software which cooperates with PyPy and CPython can be done even easier using new tools (mentioned in *What can we do*)  then relying on *c extensions*.



CPython legacy
**************

Here I need to admit the  great legacy of CPython dependent code (due to tight relying of c extensions). Mainly it is scientific software (NumPy, SciPy ...). Python is used by scientists long before PyPy became production ready (I think it was 2 year ago), and since that time it grows in terms of tools, codebase and community. All of them make a brilliant platform which is often choose as an alternative to Matlab and others (someone can even argument as a better alternative). Even thought c extensions was the only ready solution to produce this. Now the efforts are still tight to CPython because there is an enormous work required to make all the scientific stack compatibility with PyPy. The simpler solution is to make some on-demand JIT - decorating particular functions and then on the fly compile them to machine code and swap them using c extensions. This idea doesn't require rewriting all the scientific platform and also provides fast runtime. The prominent project which use this idea is **numba** sponsored by Continuum Analytics (the company which deliver robust scientific platform based on python libraries). Numba chose this direction because it wants to make fast scripts compatible with all other scientific code which now is depend on CPython. It is worth to learn about numba. Good explanation can be found at `numba talk <http://www.youtube.com/watch?v=WYi1cymszqY>`_ from SciPy conference.

I must say that the community around scientific Python is great. They really care about quality, usage  and promotion (by organizing a lot of conferences: SciPy conf, PyData) of their products. Thanks to them Python is the first choice free platform for scientific analysis. I need also to mention about Travis Oliphant, who put a lot of effort in the community and makes the whole platform coherent. Some summary about this can be found in a blog post: `Why Python Is the Last Language You'll Have to Learn <http://jakevdp.github.com/blog/2012/09/20/why-python-is-the-last/>`_

What about PyPy?
----------------

I wish that PyPy was not production ready before.



References
**********

[1] `A new JIT compiler for a faster CPython discussion <http://www.gossamer-threads.com/lists/python/dev/998582>`_ |br|
[2] `Multicore programming <http://morepypy.blogspot.com/2012/08/multicore-programming-in-pypy-and.html>`_ |br|
[3] `The story of stackless <https://ep2012.europython.eu/conference/talks/the-story-of-stackless-python>`_ |br|
[4] http://technicaldiscovery.blogspot.no/2011/10/thoughts-on-porting-numpy-to-pypy.html |br|
[5] `Static Compilation - That is the point <http://nuitka.net/posts/static-compilation-that-is-the-point.html>`_ - Summary of problems when developing whit Cython. |br|
[6] `Why Python Is the Last Language You'll Have to Learn <http://jakevdp.github.com/blog/2012/09/20/why-python-is-the-last/>`_ |br|
[7] `Pushing Python Past the Present <http://archlinux.me/dusty/2012/10/04/pushing-python-past-the-present/>`_ |br|
