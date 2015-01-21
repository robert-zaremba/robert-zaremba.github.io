Why declarative way of React is superior then all JavaScript MVC frameworks
===========================================================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::


http://www.quora.com/React-JS-Library/How-is-Facebooks-React-JavaScript-library


The idea for the next stage is to early transform the project structure. Objectives:

* easy, not overcomplicated.
* *declarative* structure. I prefer to have a clear and short model.
* flat design.
* to much abstraction kills abstraction.
* have some market proven framework which will structurize our project in a smooth and easy to maintain fashion.

Why declarative structure is superior?

* Is more straightforward. Rendering whole component based on data is much easier and requires less logic then tracking changes of a data and updating the component. The letter requires much more wiring of component model properties.
* Is more efficient. JavaScript is far faster then DOM manipulation.

The common way of building UI is to first render your template, but then wire up events between your model and the DOM so when a particular property on your model changes, you can get a specific piece of the DOM (e.g. via jQuery) and update some property on it or it's contents. This works for small projects, but there's a performance penalty for doing this sort of thing lots of times in a single frame of execution since querying and updating the DOM are pretty expensive operations. It also tends to produce tons of boilerplate code.

After evaluating different solutions I found that [React](http://facebook.github.io/react/) meets our needs.

React's code feels reasonably mature to me – since it's been used by both Facebook and Instagram in production for a while now. It looks like most of the issues have been ironed out.
