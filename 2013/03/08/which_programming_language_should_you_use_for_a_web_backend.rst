Which programming language you should use for a web backend
===========================================================

.. author:: default
.. categories:: IT
.. tags:: go, Python
.. comments::

Probably a lot of business clients are worried about technology stack they want to use for their IT web services.
Recently I was talking with some company about new project. They were concerned about technology they should use for their web startup.

It is a responsible decisions, and a lot of people have similar concerns. If you want to contract a serious project, you probably want to be aware about technology choice, you won't end up in a dirty hole.

For a frontend you don't have many options. You probably end up with W3C standards + JavaScript.
For a backend the things are different.

Requirements
************

When choosing a programming language you should start with collecting requirements:

* How many users you want to handle (overall)?
* How many users you want to handle per second?
* Does your application needs to have real-time communication with a server?
* Do you have third party libraries you want to use?

More complicated jobs are done by separate workers.

Assuming you want to use stable environment, and don't be limited by libraries support you will probably consider the most popular programming languages.
I will quickly discuss some of them.

Java
----

Chosen by big players. It doesn't mean that Java is the best one. Java was built around Enterprise model. At the beginning they planed to make business around it (the same .NET). It means that Java is:

* reliable,
* expensive. The costs come with overcomplicated solutions.

But it also means that they are overestimated. Just check how popular web framework are going. Which startup is using Enteprise now? It's complicated. Sprigs goes towards Rails model now (and still doesn't have WebSockets support). Leading companies, which want to have Java stack, prefer new fresh solutions (Play, Scala etc...) - LinkedIn, Xerox. Google have their own solutions. Oracle? They took open MySQL and almost close it. Just look how they did with 5.6 release.

Python / Ruby
-------------

Very fast developing and prototyping. Enjoy when coding, easy to maintain and refactor. Most of the web is driven by Python / Ruby / PHP frameworks (I don't want to talk about the last one). Those languages are built by professional geeks.

Disadvantage: not as fast as Java. But for serving web content it is fast enough.
Because there are implementations with JIT (eg PyPy, Numba for Python), this disadvantage is going to be even weaker. JIT gives a huge boost.

Others also can argue that dynamic type languages (like Python, Ruby) are error prone. Static types allows you to find bugs earlier, but only some of them. If want to rely on static type checking, then I feel sorry for your applications and developers. All in all you need to have tests that cover all functions. Those tests, by the way, make validations about arguments (types) you pass to functions. On the other hand Java type hierarchy slows your development and makes refactoring hard.

Node.js
-------

Like the previous one. Brings performance rather then reliability.


`Go <http://golang.org/>`_
--------------------------

The newcomer. Takes the best from Java (fast) and Python / Ruby (fun, productive). Have simple yet powerful type hierarchy. Disadvantages: although the project is stable, there are not a lot of tools around it. Some which exists are not as rich / mature as the ones we have in previous technologies.

Nonetheless Go is already used in production (Google, Heroku). It proves its usability and productivity as a general programming language: http://www.youtube.com/watch?v=kKQLhGZVN4A . The teams, which give Go a chance are happy for this decisions.


Which one to choose?
********************

Long story short: **choose the one for which you have proficient developers**. Really!

Web backend doesn't require so much complicated tools (those are done through separate workers, if not then it means your app is unsafe and aware of critical bugs, data crash etc...).


Which I'm choosing?
*******************

If I need to make a choice I will choose Go or Python. Go has a great network and concurrency support. Actually I'm developing `surfer <https://github.com/scale-it/surfer>`_ - new web framework in Go programming language. I just don't like Java. Even Scala - it's hard to find specialists and is over-complicated (thought once I was `fascinated </docs/scala.html>`_ about it). Just compare the results:

* `why I don't like Java <https://www.google.com/search?q=why+I+don't+like+java&ie=utf-8>`_ google query. The second position from *Ask Hacker News* is quiet interesting: http://news.ycombinator.com/item?id=4406224 . Please, read the first (most scored) response - by *strlen*
* `why I don't like Python <https://www.google.com/search?q=why+I+don't+like+python&ie=utf-8>`_  google query. Surprisingly we have analogous *Ask Hacker News*:  http://news.ycombinator.com/item?id=1463425 - again the first (most scored) response by *gte910h* makes my point.

Believe me I haven't read those post before. I've just wanted to prove that other geeks share similar opinion. And I was positively surprised.
