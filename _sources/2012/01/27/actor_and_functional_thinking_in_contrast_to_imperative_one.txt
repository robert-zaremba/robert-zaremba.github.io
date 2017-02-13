Actor and functional thinking in contrast to imperative one
===========================================================

.. author:: default
.. categories:: computer science
.. tags:: scala
.. comments::


After reading `"Why has the actor model not succeeded?" <http://www.doc.ic.ac.uk/~nd/surprise_97/journal/vol2/pjm2/>`_ (which I really recommend to read) I've started to think about similarities with functional languages.

Actor model was introduced to as an easy and straight solution for designing distributed systems.

Functional languages substitute imperative style focused on "how machines think" by a maths model - "how human would think straight away".

.. more::

The problem with Actor model is we think about some program to call a method or to send a request to make a method. If we think to call a method then we have this method and we can call it. On the other way if we think to send a request then we have a "tool" which performs sending request. That is a straight way.

In actor model encapsulation goes with actors itself. So if we want to hide some abstraction in a "boxes" we make an actor which has functionality of an abstraction. Then if we want to use the functionality we need to send a message as a request to an actor.

On the other hand Functional programming model allows us to directly call the function, deliver great tools to message passing, and abstract distribute system by simply functions. And we still think functional.

For those who want an object hierarchical model (prefer abstraction with inheritance rather than higher kind of polymorphism like Abstract Data Types, classtypes or functors) there is great language: `Scala <http://scala-lang.org/>`_ which is brilliant in mixing object oriented programming with functional.

I will try to approach Scala in next posts.
