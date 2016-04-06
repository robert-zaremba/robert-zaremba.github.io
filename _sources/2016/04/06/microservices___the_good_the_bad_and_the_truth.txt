Microservices - the good the bad and the truth
==============================================

.. author:: default
.. categories:: design
.. tags:: software-engineering
.. comments::


You may went through this multiple times: *Why should I consider a microservices architecture?*
It has been written and spoken a lot in recent years about Microservice Oriented Architecture (MOA). I'm not going to describe it, because there is enough about this in internet\ [1]_ and books (highly recommend `Building Microservices 2015 <http://shop.oreilly.com/product/0636920033158.do>`_ from O'Reilly).
Here I will like to discuss which project should consider implementing Microservice Oriented Architecture.

Compared to `monolithic systems <http://www.c2.com/cgi/wiki?MonolithicDesign>`_, microservices:

* are easier to scale;
* are easy to incorporate new technology;
* are easier to manage and develop in multi-team company;
* provide good development patterns;
* difficult to start;
* more complex to setup. They require distributed system which can be complex and hard to manage (though if you need a distributed setup this is the way to go);
* require more tooling;
* require experienced team to do it correctly (microservices increase amount of infrastructure and operations management);
* `Seven micro-services architecture advantages <http://eugenedvorkin.com/seven-micro-services-architecture-advantages>`_;
* `Quora: What are some disadvantages of a microservice architecture? <https://www.quora.com/What-are-some-disadvantages-of-a-microservice-architecture>`_;


The whole concept of service oriented architecture is old, but the first big implementation and promotion of MSA has sprung up around 2005 ([2]_, [3]_). It took more then 20 years of software engineering to find the first big implementation of this pattern (I'm assuming here that large scale software engineering started in mid 80') and additional 10 years to find out how to do it correctly.


Antipaterns when approaching MOA
--------------------------------

When going to microservice oriented architecture you can easily trap into common antipatterns:

* Nanoservices.
  *Nanoservice is an Anti-pattern where a service is too fine grained. Nanoservice is a service whose overhead (communications, maintenance etc.) out-weights its utility.*\ [4]_ Few important downsides of nanoservices: performance issues (eg: network round-trips, serialization cycles), increased maintenance cost, dependency spaghetti (mixing  and splitting logic to much between services). The first mark of nanoservice is when the amount of infrastructure and networking code of a service takes over the amount of business code.

* Don't allow business context to be mixed across many services. Keep `Bounded Context <http://martinfowler.com/bliki/BoundedContext.html>`_.

* Common practice in a microservices architecture is to segment services and their corresponding data management systems. Since each database is segmented to support the service, management of the databases and its data becomes much more difficult.

* Moving communication to a storage layer. If you delegate a part of communication between microservice then they will not be independent any more.

* Integrate to late. Imagine that a web page is served through multiple services. Each response must be integrated and presented in one view. All parts of this view must be consistent. What's even more harder: they might interact between each other and depend on single style definition.



SOA (Service Oriented Architecture) to unleash!
-----------------------------------------------

Do you remember what software architects were advocating in early 2000s? SOA! Please recall `What is service-oriented architecture? <http://www.javaworld.com/article/2071889/soa/what-is-service-oriented-architecture.html>`_. The basic SOA concept from early 2000s provides simply and good system design which can easily scale to microservices and doesn't brings it's obstacles from the very beginning.


Should I start with Microservices?
----------------------------------

Don't follow the hype. What's good for a big companies might not be good for you. As a general principle you should consider pros and cons, counting: project size, system complexity, team size and business perspective [5]_. Well managed monolith system are not that bad for small projects. SOA applications with well managed master service and multiple specialized services are more then enough for most of the projects you can think about.

    > Stack Overflow site is non-microservices-based-platform, with 4 milion registered users, is working on just 11 web servers. Compilation of all platform (.NET) takes 10 seconds. 110k lines of code. Well designed code by Joel Spolsky(tm)

That being said, whenever doing a long term project you should always think about MOA. If you don't have scale requirements now your team is small - try to think that you will have them in one month. Don't over-engineer, but follow the well thought patterns and SOA.

-----------------------


.. [1] Why should I consider a microservices architecture? https://technologybeacon.wordpress.com/2016/03/24/why-should-i-consider-a-microservices-architecture/
.. [2] Martin Fowler nicely describes the concept and history of microservices at http://martinfowler.com/articles/microservices.html#footnote-etymology
.. [3] Wikipedia: Microservices - https://en.wikipedia.org/wiki/Microservices
.. [4] https://en.wikipedia.org/wiki/Microservices#Nanoservices
.. [5] `Should you build microservices from day 1? <https://www.quora.com/Should-you-build-microservices-from-day-1>`_
