Tornado - the best Python web framework
=======================================

.. author:: default
.. categories:: IT
.. tags:: Python, tornado, wsgi
.. comments::

.. |br| raw:: html

    <br />


Today web frameworks mostly utilize HTTP requests, usually delivering MVC stack. But web framework should do different (because of the *web*!). |br|
Now web consists mostly of patterns around HTTP protocol (HTTP itself, RESTful, HTTP API ...). Moreover we have bidirectional communication, *long requests*, high traffic etc... |br|
Ideal framework must:

* have generic methods, network libraries and asynchronous support to handle previously mentioned staff.
* be extensible for new web (web2.0, web3.0 ...)
* be aware about Python WSGI standard
* have features to easily develop www platforms
* have a good documentation and community

MVC stack is not the of every web framework. Although, there should be a simple way to apply it using available solutions.

In this post I will try to explain why I consider WSGI non sufficient and present *Tornado*, which handles *ideal web frameworks* problems greatly.


WSGI vs Tornado application and WebSockets
##########################################

Standard Tornado application (``tornado.web.Application``) is not WSGI compliant. |br|
It is designed as a lightweight application for Tornado HTTP server.

`WSGI <http://www.python.org/dev/peps/pep-3333/>`_ is a standard interface for python web applications. It defines how to handle http request and making responses in simple way abstracting from HTTP protocol. But it has some drawbacks. From the first time it looks cool and simple as opposite to handling HTTP. You abstract from parsing request. WSGI provides you a method to write heads and you yield body response. The design allows you to make middlewares, which is a really cool idea. All of this looks nice. |br|
But the devil is in the details. WSGI doesn't works well with *upgrade* or other interesting features of HTTP.
Some examples of WSGI flaws:

* there was a big, long unicode support issue which was resolved by final WSGI spec (pep 3333) which was accepted in 2011! (too late!). The solution only fix single problem.
* you *must not apply any kind of Transfer-Encoding to their output* (from wsgi spec) . So gzipping is out from application/frameworks. According to WSGI this task should be done by http server. But it doesn't have information which output is eligible to compress and which is not. All major frameworks (Django, Pyramid...) breaks this rule.
* *chunked encoding* must be handled by server. So if you want to be strict with a standard, then you have a problem with long polling implementations - which will depend on server configuration / implementation. Server has no information about authors application details.
* WSGI suppose to parse environment variables by each middleware separately (consuming cpu time).
* design in a spirit of old CGI, low level interface which is always hide by the frameworks
* there is no official API for WSGI. We have only server - middlewares - application. The only thing we can do is to change order of middlewares. But they are also limited (we can't use middleware *X* before *Y* in both request and response path). There is no standard way to customize middlewares from application.
* middlewares and application only share *environment*. Let hope non middleware will not poke each other values. Just check dirty implementations of *WebSockets* around WSGI stack.


Those problems simply don't exist in Tornado. What's good about WSGI, it is a standard, allowing to handle WSGI applications in the same manner.

`WebSockets <http://dev.w3.org/html5/websockets/>`_  (great `guide <http://buildnewgames.com/websockets/>`_) protocol is going to replace AJAX communication. Thanks WebSockets we get seamless bidirectional communication with a server - so we can easily synchronize objects on user side, implement push notifications and so on.
WebSockets doesn't has request-response pattern. It is designed upon existing HTTP infrastructure but only resembles HTTP at the beginning - the handshake is HTTP, after that the protocol is a non-blocking message passing preserving the same connection. In other words it upgrades from HTTP to TCP or UDP connection. WebSockets concerns only those connections which one of the endpoint is a browser. So don't get it as an ideal *new age* communication layer for everything. |br|
There is a long discussion of concerns about this design. The main advocacy is to use the same infrastructure as www does (server, 80/443 port). The design of WebSockets is not a subject of this post.

Unfortunately WebSockets doesn't go well with WSGI applications.
The problem is with WSGI itself. WSGI is stateless and is designed for a following process: make request -> handle request -> prepare headers -> make response -> finish request. The result is WSGI does not support non-blocking requests. However there are WSGI - WebSockets tandem implementations for common WSGI web frameworks which requires additional async event framework (`example <http://blog.eventlet.net/tag/wsgi-websocket-standard/>`_). But they looks like makeshift solutions.

Programmers usually ends with writing two web server applications: one for WebSockets and other for http - wsgi.

Tornado web applications are not WSGI applications. At the beginning they are designed to work with event loop. So with Tornado you can mix all web smoothly (www server, WebSockets...)

Because of unstable vision of WebSockets there is an advice to separate them from your www applications. Still with Tornado you can use the same code.


WebSockets is not everything
****************************

WebSockets is not everything. Your web framework needs to easily integrate with other protocols (like `Server-sent event <http://en.wikipedia.org/wiki/Server-sent_events>`_, tornado `implementation <https://github.com/guyzmo/event-source-library>`_), SocketIO and HTTP upgrades. The last one are getting popular for *presence services*. Tornado do that (read below sections).


Tornado for WSGI
****************

But if you have a wsgi application and you want to use Tornado, or you have Tornado application and you want to deploy it as a WSGI one, then nothing stops you.
Tornado delivers wrapper for both.

If you want to transform your Tornado app, just use ``tornado.wsgi.WSGIApplication``, and you will end up with lightweight, WSGI application which you can deploy on *uwsgi*, *mod_wsgi* and others. The only limitation is you can't use any asynchronous/non-blocking features of Tornado (for the reasons from previous section).

On the other hand, if you already have WSGI app and want to run it on a blazing fast ``tornado.httpserver.HTTPServer``, wraps it with ``tornado.wsgi.WSGIContainer``. |br|
But you need to be careful. Since your original application is not prepared for asynchronous server, and will make a lot of IO/computation, it will block other other requests to make response (the requests will be accepted and buffered, but will be waiting in queue for handling).


Tornado for www frameworks
**************************

Most other web frameworks try to deliver one box for developing web portals, leaving the network side.

* Django is a heavy framework with already established design for you application. You've got Django ORM, buildin template engine, enforced application desing, forms generators and so on. All of this works well if you work with RDBMS and 12 years old web pages design. Now we have RDBMS, NoSQL DB, client side frameworks, REST. If you want to make in Django way it could start to be messy. But we have a lot of Django legacy. So for simple web portals maybe it's still a good idea.
* *micro www frameworks*: Flask, Bottle.  WSGI wrappers + routing. Great for simple REST wsgi apps!
* Pyramid - highly customized box for writing full staff application. Great if you want more features than Bottle, Flask can give you (or you prefer working with Flask extensions)

Tornado on the other gives you highly customized application model with a great network library.
With Tornado you don't need to suffer all well known features. It is easier to extend then using Pyramid or Flask, has more features then *micro www frameworks*. But it not ships www features which you could have with Django / Pyramid and you need to write slightly more code then with *micro www frameworks*. Someone can argue that using Django/Flask... is easier to write apps, since Tornado uses callbacks. But this is an option! you don't have to use any asynchronous functions in you handlers! You can use it and benefit, or you can live without them.

So you are not tight to WSGI, nor you don't have to do all by yourself. Tornado already is used in big production stories (both for API server and html content):

*  http://friendfeed.com/
*  http://bit.ly
*  http://quora.com
*  `others <http://tornado.poweredsites.org/>`_

As noticed, **Tornado has a great ecosystem with a lot of libraries and drivers** which utilises asynchronous connections. The list of them (not exhaustive) you can find on https://github.com/facebook/tornado/wiki/Links

Asynchronous framework
######################

Thanks speed and simplicity Tornado becomes very popular in Python asynchronous libraries.

There is a PyCon talk which presents superb of Tornado: http://www.pyvideo.org/video/720/more-than-just-a-pretty-web-framework-the-tornad . There is also a funny story about Twisted and and Tornado devs - in the second half of the video. |br|
The main points are:

* beautiful, clean code
* simple, easy (in contrast to other callback frameworks) yet powerful
* great libraries support (with twisted protocols legacy thanks ``tornado.platform.twisted``)
* integrates SSL
* integrates in www/HTTP infrastructure and beyond that.
* pure Python. Works with **PyPy**
* Performance. Serving network performance is similar to *gevent* one, but under PyPy it's far better! Check `Benchmarking python web servers on pypy and cpython <http://casbon.me/what-will-pypy-do-for-your-website-benchmarki>`_ and `Python vs. Node vs. PyPy <http://blog.kgriffs.com/2012/10/23/python-vs-node-vs-pypy.html>`_

If you don't like callback style, you can use ``tornado.gen`` which takes you back to synchronous style (preserving non blocking).
Moreover if you are happy with Tornado stack, but want to use green version of std lib from eventlet, or just monkey patch from *eventlet* and transform blocking libraries into non blocking ones (if the IO blocking operations relays only on python std lib) then try `greentornado <https://github.com/vishnevskiy/greentornado>`_ . It really works!

Interestingly, the creators of Tornado suggest to use blocking libraries for really short operations (eg: DB operations), and running more application instance then CPU cores - to handle those short breaks. If operations, which are suppose to be really short (DB), are long then consider latency problem inside your application, wrong architectural design or your application really requires this so you have to use Tornado based drivers for those operations.

Asynchronous frameworks are great if you need to handle enormous amount of connections or working with IO blocking / distributed task. And Tornado helps to make it easy and reliable.

There is also a lot other Python asynchronous libraries. I will try to make an opinion, why Tornado is better, and make some comparison.

Twisted
*******

It is very similar with Tornado in design concept. Both use mainly callback style and has buildin pure Python event loop powered back by *epool* (on Unix).

Twisted, like the name indices, is *twisted*. The big plus for Twisted is it's variety of buildin protocols and web standards.
Although it's complicated. You not only have callback, but also deffereds. If someone try to say that deffereds are not complicated - don't belive him. It doesn't seem I'm fool. The idea of deffereds is simple yet powerfull. But using it complicates the programm structure. It doesn't brings any simplicity at all. Neither your programm is shorter. Just the same way as *goto* in C. But when you use it, you will have a problem with testing and debugging. And other programmers when come and start reading your code will try to kill you.
Besides this twisted is overcomplicated in the way you can handle the problem. Just try to make an client for echo server by your own. In python std lib is easier and cleaner.

Gevent
******

There is a lot of words about Gevent on the internet. The version with libevent is abandoned, and the new one (1.0) can't get away from beta version for 3 years.
Ut's tied to CPython implementation. You can't use it with othe python implementations (PyPy, Jython...).

Diesel
******

I like it. The people who design Diesel are smart. The actual version is thier 3rd attempt to design good asynchronous library. They started with generators idea (using yield for async calls) - like in `asyncoro <http://asyncoro.sourceforge.net/>`_. And they end up using greenlets. I played with all versions. And I can admit that the last one (it's tidy up from the second one) is really cool when you want to async applications and don't want to play with callbacks.

Like in Tornado you get a bunch of tools and utils to IO programming. So you can abstract from clunky socket and get nice, awesome interface to network and asynchronous staff. As mentioned above, it uses greenlets which allows to programming asynchronously in a sync way. It works with PyPy. But PyPy can uses it's JIT when operating on *green/task lets*. It's going to change, but the progress is slow. I would like to here PyPy JIT support and community for Diesel.


Eventlet
********

We can think of this as a pure Python version of Gevent. It has Stackless support and works with PyPy (it is not stable but there are efforts to change it). What's good it can successful monkey-patch standard library and make standard IO asynchronous (like Gevent do).
Eventlet doesn't have fancy stuff as Diesel have, but it has a far better commercial (OpenStack) usage and recently active maintainers.

It was almost dead. One year ago the status was: *the API is stable, the founder said that features are all on, there were no active maintainer* (https://lists.secondlife.com/pipermail/eventletdev/2012-July/001066.html). But in the middle of 2012 successfully revived the community, took a control on the package and push bug fixes and encouraged other to help. |br|
Now the project is health. Maintainers put a lot of effort to make improvements. `Read <https://lists.secondlife.com/pipermail/eventletdev/2012-December/001103.html>`_  the summary of the current status and what have been done.

It doesn't have such nice interface as Diesel has, and community/ecosystem Tornado has. But there are players around who can change it. So it's worth to keep it in mind.


Others
******

There is a lot of others. I wanted to describe only the representatives of different architecture ideas and direct competitor (twisted).
All of syncless, asyncoro, whizzer ... easy fit in one of above group or has no support in community / libraries.
