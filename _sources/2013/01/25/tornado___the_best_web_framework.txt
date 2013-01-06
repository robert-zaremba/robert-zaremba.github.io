Tornado - the best Python web framework
=======================================

.. author:: default
.. categories:: IT
.. tags:: Python, tornado, wsgi
.. comments::

.. |br| raw:: html

    <br />


Today web frameworks mostly utilize HTTP requests, usually delivering MVC stack. But web frameworks should do different (because of the *web*!). |br|
Now web consists mostly of patterns around HTTP protocol (HTTP itself, RESTful, HTTP API ...). Moreover we have bidirectional communication, *long requests*, high traffic etc... |br|
The ideal framework must:

* have generic methods, network libraries and asynchronous support to handle previously mentioned stuff.
* be extensible for new web (web2.0, web3.0 ...)
* be aware of Python WSGI standard
* have features to easily develop www platforms
* have good documentation and community

It's not the aim of every web framework to provide an MVC stack. Although, there should be a simple way to apply it using available solutions.

In this post I will try to explain why I consider WSGI insufficient and present *Tornado*, which handles *the ideal web framework* problems well.


WSGI vs Tornado application and WebSockets
##########################################

The standard Tornado application (``tornado.web.Application``) is not WSGI. |br|
It is designed as a lightweight application for Tornado HTTP server.

`WSGI <http://www.python.org/dev/peps/pep-3333/>`_ is a standard interface for python web applications. It defines how to handle HTTP requests and making responses in a simple way abstracted from HTTP protocol. But it has some drawbacks. At first it looks cool, and simple then handling HTTP directly. Request parsing is abstracted. WSGI provides a way to write heads and provide a response body. The design allows you to make middlewares, which is a really cool idea. All of this looks nice. |br|
But the devil is in the details. WSGI doesn't work with the *Upgrade* header or other interesting features of HTTP.
Some examples of WSGI flaws:

* There was an important, long-standing Unicode support issue which was resolved by final WSGI spec (PEP 3333) which was accepted in 2011! (too late!). The PEP only fixed this one problem.
* *Apps and middleware must not apply any kind of Transfer-Encoding to their output* (from `wsgi spec <http://www.python.org/dev/peps/pep-3333/#handling-the-content-length-header>`_). So applications and frameworks cannot gzip responses. According to WSGI, this task should be done by the HTTP server. But it doesn't have information which output is eligible to compress and which is not (it can compress all responses or none). All major frameworks (Django, Pyramid...) breaks this rule.
* *Chunked encoding* must be handled by the server. If you want to stick to standards, then you have a problem with long polling implementations - which will depend on server configuration / implementation. Server has no information about authors application details.
* Each WSGI middleware has to parse parse environment variables independently (consuming extra CPU time).
* WSGI is designed in the spirit of old CGI: a low-level interface always hidden by the frameworks
* there is no official API for WSGI. We have only server - middlewares - application. The only thing we can do is to change order of middlewares. But they are also limited (we can't use middleware *X* before *Y* in both request and response path). There is no standard way to customize middlewares from application.
* middlewares and application only share *environment*. Let's hope non middleware will not mess with each other's values. Just check dirty implementations of *WebSockets* around WSGI stack.

Those problems simply don't exist in Tornado.
The good thing about WSGI is that it is a standard, allowing WSGI applications to be handled in a uniform manner.

`WebSockets <http://dev.w3.org/html5/websockets/>`_  (great `guide <http://buildnewgames.com/websockets/>`_) protocol is going to replace AJAX communication. Thanks to WebSockets we get seamless bidirectional communication with a server - so we can easily synchronize objects on user side, implement push notifications and so on.
WebSockets doesn't have a synchronous request-response pattern. It is designed upon existing HTTP infrastructure but only resembles HTTP at the beginning - the handshake is HTTP, after that the protocol is non-blocking message-passing preserving the same connection. In other words, it upgrades from HTTP to TCP or UDP. WebSockets is only concerned with connections to a browser. So don't assume it is the ideal communication layer for everything. |br|
Many concerns have been discussed about this design. The main adventage is to use the same infrastructure as www does (server, 80/443 port). The design of WebSockets is not a subject of this post.

Unfortunately WebSockets doesn't go well with WSGI applications.
The problem is with WSGI itself. WSGI is stateless and is designed for the following process: make request -> handle request -> prepare headers -> make response -> finish request. The result is that WSGI does not support non-blocking requests. However there are WSGI - WebSockets tandem implementations for common WSGI web frameworks which require an additional async event framework (`example <http://blog.eventlet.net/tag/wsgi-websocket-standard/>`_). But they look like makeshift solutions.

Programmers usually end up writing two web server applications: one for WebSockets and other for WSGI.

Tornado web applications are not WSGI applications. From the beginning they are designed to work with an event loop. So with Tornado you can mix all web smoothly (www server, WebSockets...)

Because frequent changes in the WebSockets standard there is advised to separate them from your www applications. But with Tornado you can use the same code.


WebSockets is not everything
****************************

WebSockets is not everything. Your web framework needs to easily integrate with other protocols (like `Server-sent events <http://en.wikipedia.org/wiki/Server-sent_events>`_, tornado `implementation <https://github.com/guyzmo/event-source-library>`_), SocketIO and HTTP upgrades. These last are becoming popular for *presence services*. Tornado does that (read below sections).


Tornado for WSGI
****************

If you have a WSGI application and you want to use Tornado, or you have Tornado application and you want to deploy it as WSGI one, there is nothing to stop you.
Tornado provides wrapper for both.

If you want to transform your Tornado app, just use ``tornado.wsgi.WSGIApplication``, and you will get a lightweight WSGI application which you can deploy on *uwsgi*, *mod_wsgi* and others. The only limitation is you can't use any asynchronous/non-blocking features of Tornado (for reasons given in the previous section).

On the other hand, if you already have a WSGI app and want to run it on a blazing fast ``tornado.httpserver.HTTPServer``, wraps it with ``tornado.wsgi.WSGIContainer``. |br|
But you need to be careful. Since your original application is not prepared for an asynchronous server, and will make a lot of IO/computation, it will block other requests while generating a response (further requests will be accepted and buffered but queued for later handling).


Tornado for www frameworks
**************************

Most other web frameworks try to deliver one stack for developing web sites, leaving network libraries. Now, in the web 2.0 (web 3.0?) era we concern more about network on the server side instead of ORM, template language (which should be chosen by the application needs).

* Django is a heavy framework which prescribes a design for you application. You've got the Django ORM, a build-in template engine, enforced application desing, form generators and so on. All of this works well if you work with an RDBMS and 12-years-old web pages design. Now we have RDBMS, NoSQL DB, client side frameworks, RESTful APIs. If you want to use this in the Django way it could start to get messy. But we have a lot of Django legacy code. So for simple web portals, maybe it's still a good idea.
* *micro www frameworks*: Flask, Bottle.  WSGI wrappers + routing. Great for simple REST wsgi apps!
* Pyramid - highly customized, feature-full framework. Great if you want more features than Bottle or Flask can give you (or you prefer working with Flask extensions)

Tornado, on the other hand, gives you highly customized application model with a great network library.
Tornado is also feature-full framework. It is easier to extend then using Pyramid or Flask, has more features then *www microframeworks*. But it doesn't have such a big library support for web portals as Django / Pyramid has (eg: ready to go comment, blog modules ...) and you need to write slightly more code for small task then with *www microframeworks*. Someone can argue that using Django/Flask... is easier to write apps, since Tornado uses callbacks. But this is an option! you  don't have to use any asynchronous functions in you handlers! You can use it and benefit, or you can live without them.

So you are not tied to WSGI, nor do you have to do everything yourself. Tornado is already used in big production stories (both for API server and html content):

*  http://friendfeed.com/
*  http://bit.ly
*  http://quora.com
*  `others <http://tornado.poweredsites.org/>`_

As noticed, **Tornado has a great ecosystem with a lot of libraries and drivers** which utilises asynchronous connections. Find a not-exhaustive list of them on on https://github.com/facebook/tornado/wiki/Links

Asynchronous framework
######################

Thanks to its speed and simplicity, Tornado has become very popular among Python's asynchronous libraries.

There is also a PyCon talk which superbly presents Tornado: http://www.pyvideo.org/video/720/more-than-just-a-pretty-web-framework-the-tornad  (there is also a funny story about the Twisted and and Tornado devs in the second half of the video). |br|
The main points are:

* beautiful, clean code
* simple, easy (in contrast to other callback frameworks) yet powerful
* great libraries support (increased by Twisted's legacy protocols thanks ``tornado.platform.twisted``)
* integrates SSL
* integrates in www/HTTP infrastructure and beyond that.
* pure Python. Works with **PyPy**
* Performance. Serving network performance is similar to *gevent* one, but under PyPy it's far better! Check `Benchmarking python web servers on pypy and cpython <http://casbon.me/what-will-pypy-do-for-your-website-benchmarki>`_ and `Python vs. Node vs. PyPy <http://blog.kgriffs.com/2012/10/23/python-vs-node-vs-pypy.html>`_

If you don't like callback style, you can use ``tornado.gen`` which takes you back to synchronous style (preserving non blocking).
Moreover if you are happy with Tornado stack, but want to use green version of std lib from eventlet, or just monkey patch from *eventlet* and transform blocking libraries into non blocking ones (if the IO blocking operations relays only on python std lib) then try `greentornado <https://github.com/vishnevskiy/greentornado>`_ . It really works!

Interestingly, the creators of Tornado suggest using blocking libraries for really short operations (eg: DB operations), and running more application instances then CPU cores - to handle those short breaks. If operations, which are suppose to be really short (DB) turns out to be long then consider latency problem inside your application, wrong architectural design or your application really requires this so you have to use drivers based on Tornado for those operations.

Asynchronous frameworks are great if you need to handle enormous numbers of connections or work with IO blocking / distributed task. And Tornado helps to make it easy and reliable.

There are many other Python asynchronous libraries. I will try to explain my opinion of why Tornado is better.

Twisted
*******

It is very similar with Tornado in design concept. Both use mainly callback style and have builtin, pure-Python event loops powered by *epool* (on Unix).

Twisted, like the name indicates, is *twisted*. The big plus for Twisted is its variety of built-in protocols and web standards.
Although it's complicated. You not only have callbacks, but also deferreds. If someone tries to say that defereds are not complicated, don't belive him. It doesn't seem I'm fool. The idea of deferreds is simple yet powerfull. But using it complicates the program structure. It doesn't bring any simplicity at all. Neither is your programm shorter. Just the same way as *goto* in C. But when you use it, you will have a problem with testing and debugging. And when other programmers start reading your code, they will want to kill you.
Besides this, Twisted is overcomplicated in the way you can handle problem. Just try to make an client for echo server by your own. In python std lib is easier and cleaner.

Gevent
******

A lot has been written about Gevent on the internet. The version with libevent is abandoned, and the new one (1.0) can't get away from beta version for 3 years.
Ut's tied to CPython implementation. You can't use it with othe Python implementations (PyPy, Jython...).

Diesel
******

I like it. The people who design Diesel are smart. The latest version is thier 3rd attempt to design a good asynchronous library. They started with generators-based idea (using yield for async calls) - like in `asyncoro <http://asyncoro.sourceforge.net/>`_. And they end up using greenlets. I played with all versions. And I can admit that the last one (it's tidier then the second one) is really cool when you want to async applications and don't want to play with callbacks.

Like in Tornado you get a bunch of tools and utils for IO programming. So you can abstract clunky socket and get a nice, awesome interface to network and asynchronous staff. As mentioned above, it uses greenlets which allows to programming asynchronously in a synchronous way. It works with PyPy. But PyPy can uses its JIT when operating on *greenlets/tasklets*. It's going to change, but the progress is slow. I would like to see PyPy JIT support and community for Diesel.


Eventlet
********

We can think of this as a pure Python version of Gevent. It has Stackless support and works with PyPy (it is not stable but there are efforts to change that). What's good is that it can successful monkey-patch the standard library to make standard IO asynchronous (like Gevent do).
Eventlet doesn't have the fancy stuff that Diesel have, but it has a far better commercial (OpenStack) usage and recently active maintainers.

It was almost dead. One year ago the status was: *the API is stable, the founder said that features are all on, there were no active maintainer* (https://lists.secondlife.com/pipermail/eventletdev/2012-July/001066.html). But in the middle of 2012 they successfully revived the community, took a control on the package, pushed bug fixes and encouraged other to help. |br|
Now the project is healthy. Maintainers put in a lot of effort to make improvements. `Read <https://lists.secondlife.com/pipermail/eventletdev/2012-December/001103.html>`_  the summary of the current status and what have been done.

It doesn't have Diesel's interface, or Tornado's community/ecosystem Tornado has. But there are players around who can change it. So it's worth to keeping it in mind.


Others
******

There many others others. I only wanted to describe the representatives of different architecture ideas and direct competitors (Twisted).
All of syncless, asyncoro, whizzer ... easy fit in one of the above groups or have no support in community / libraries.

|br|

My experience in web field
**************************

I worked with web projects using all of *web frameworks* mentioned above. The biggest were in Tornado, Django (including OpenStack), repoze.bfg (Pyramid), Bottle.
