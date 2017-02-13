Which technology for realtime communication for a web app?
==========================================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::


Web is the main medium to share information and access data on internet. It is usually tight to browser - proxies/routers - *web* server. The main protocol is *HTTP* and most of the internet services are HTTP oriented.

HTTP at the beginning was only about one site communication: client makes a request to server and server prepares response. Now web is more then simple request response. It's a medium for application. And applications often require more then a single site communication.

*push notifications* - often denoted as a mechanism which allow server to sent requests / events to a client.

There are a lot of solution to integrate HTTP with bi-directional communication, to implement *push notifications* for a web server.

.. more::

Instead of describing available solutions, I will point to some resources, which did it:

* `Push technology <http://en.wikipedia.org/wiki/Push_technology>`_ - Wikipedia article, quiet technical.
* `What are Long-Polling, Websockets, Server-Sent Events (SSE) and Comet? <http://stackoverflow.com/questions/11077857/what-are-long-polling-websockets-server-sent-events-sse-and-comet>`_  - clean overview of *push* technologies, TLDR for those who don't want read Wikipedia article.
* `Stream Updates with Server-Sent Events <http://www.html5rocks.com/en/tutorials/eventsource/basics/>`_ - a great overview for Server-Sent Event Technology.


Programmers ask a question:

* Which realtime technology should I use for realtime communication?
* What to use for *push notifications*
* WebSockets vs Server-Sent Event vs Comet
* Socket.IO vs SockJS or pure WebSockets?


`WebSockets <http://en.wikipedia.org/wiki/WebSocket>`_ is probably one of the best solution. It provides fast and secure bidirectional connection. All we need in terms of functionality. But it has some drawbacks:

* Hard to implement.
* Evolving standard. Not all client libraries are compatible with the newest one.
* It's not HTTP. It resembles only at the beginning - on handshake. Then it updates to `WebSockets` protocol. This mean that it can make a problems on some HTTP based infrastructures (proxy servers, firewalls, ...).
* Lacks automatic reconnection.

You can also look at SockJS or Socket.IO, which abstracts from the underground transport layer and provide you good, *WebSockets* like API for your realtime communication. This is especially useful when you need to support different clients (mobiles, desktop browsers...).

The problem with Socket.IO is that it is equated to it's Node.js implementation on a web server. Other implementations are quiet behind and has some potential problems with new library versions.

SockJS has better interoperability and parallel supports other implementations on web servers.


Server-Sent Events
------------------

Finally if your client requirements are not so big (IE 8+, Firefox 6+, Chrome 6+, Safari 5+, Opera 11+ is enough) you *should* look at `Server-Sent Events <https://en.wikipedia.org/wiki/Server-sent_events>`_

SSE is a regular HTTP and uses single long streaming connection. It has lot of advantages:

* Transported over regular HTTP instead of a custom protocol (using HTTP streaming) - you don't need special server implementation!
* It's much simpler to implement and debug. Protocol is dead simple and it's all text. You don't need huge server-side library or 3rd party service, You can just print the lines yourself.
* Fast and secure. Even faster to initiate then WebSockets. Also the protocol has less overhead (messages are not divided into frames/packets).
* Doesn't require any tricks or reconnects you can find in `Comet <http://en.wikipedia.org/wiki/Comet_%28programming%29>`_ implementations.
* Built in support for automatic re-connection and event-id.
* It can switch between permanent connection and polling at any time, so you can change strategy depending on your server load (e.g. if you run into connection limit, just drop some clients, they'll reconnect in couple of seconds).

All you need is a client with a good HTTP support. If your browser doesn't provide Server-Sent Events API (EventSource) you can easily `polyfill <https://github.com/Yaffle/EventSource>`_ it.

The only drawback is that SSE connections are simplex - only capable to send data (events) from Server. For most of the use cases it is not a problem. You can use HTTP XHR requests and stay with your HTTP web application server! It performs really good for most scenarios.

When SSE is not good enough?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Good answer for this question comes from `HTML5Rocks <http://www.html5rocks.com/tutorials/eventsource/basics/>`_ article:

  One reason SSEs have been kept in the shadow is because later APIs like WebSockets provide a richer protocol to perform bi-directional, full-duplex communication. Having a two-way channel is more attractive for things like games, messaging apps, and for cases where you need near real-time updates in both directions. However, in some scenarios data doesn't need to be sent from the client. You simply need updates from some server action. A few examples would be friends' status updates, stock tickers, news feeds, or other automated data push mechanisms (e.g. updating a client-side Web SQL Database or IndexedDB object store). If you'll need to send data to a server, XMLHttpRequest is always a friend.

That means we can go rid of realtime framework and maintain additional services.  Just use Server-Sent Events!

---------------------------------------------------------

In my `new project <http://www.agflow.com>`_ we moved from SockJS to Server-Sent Events. I'm extending `Go <http://golang.org/>`_ Handlers to support SSE. It's really easy.

Want to read more? Take `html5 Doctor <http://html5doctor.com/server-sent-events/>`_ article.
