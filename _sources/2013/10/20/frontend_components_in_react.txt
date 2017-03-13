Frontend components in React
============================

.. author:: default
.. categories:: frontend
.. tags:: javascript
.. comments::

.. |br| raw:: html

    <br />


Last week I made a presentation for `meet.js PL <http://summit.meetjs.pl>`_ about `React <http://facebook.github.io/react/>`_. *meet.js* is a free front-end meetup organized by web enthusiasts in 6 major Polish cities - Warsaw, Gdańsk, Poznań, Wrocław, Cracow and Katowice.

In a nutshell, I presented why we chose React among other available options (ember.js, angular, backbone ...) in `AgFlow <http://agflow.com>`_, where I'm leading the development team.

Also I try to highlight some problems with *MVC pattern everywhere*.

I really like a way of React frontend components development. It makes more clear for us to implement use cases views.

.. more::

Enjoy! |br| |br|

.. raw:: html

    <iframe src="https://docs.google.com/presentation/d/1JSFbjCuuexwOHCeHWBMNRIJdyfD2Z0ZQwX65WOWkfaI/embed?start=false" frameborder="0" width="600" height="468" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"> </iframe>



meet.js notes
-------------

After the presentation I was asked several times how react handles relation with a model we want to present. During the talk a wanted to highlight that React is not about implementing a *Model*, but a way to construct visible components with some state. React is simple. It is super simple, you can learn it in 1h. On the other hand what is model? Which functionality it should provide? React does one thing and does it the best (for me)!

There are bunch of libraries which handle non visible part of web front-end, which we can easily incorporate for:

* browser-server real-time synchronization
* routing
* collections
* router
* history
* schema
* cache, storage
* templates (still we didn't encounter a use-case to even think about them)
* proxy ...
* notifications

It's worth nothing that some of those features are such easy to achieve, that we don't need to use a heavy machinery to implement it.


In Angular I can do X
~~~~~~~~~~~~~~~~~~~~~

Sure, there are bunch of features implemented in Angular which are not available in React. I admit that React is not as powerful as Backbone.  Again: *React does one thing and does it the best (for me)*! But we are super satisfied what it does.

We could afford for a choice of technology. We chose React.
