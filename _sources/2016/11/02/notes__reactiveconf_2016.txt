Notes: ReactiveConf 2016
========================



.. author:: default
.. categories:: it
.. tags:: javascript
.. comments::


The `ReactiveConf 2016 <https://reactiveconf.com/2016/>`_ is a great venue where you meet and hear from the new technology drivers, early adapters and it innovators. It had place in the organizers home town - Bratislava, which is another reason to attend the conference - to visit a charming part of the west Europe.

Despite the name, the conference wasn't much about `React <https://facebook.github.io/react>`_

.. more::

Note: The cover letter of the majority of presentation was *This library is awesome, but in alpha stage, so use it under your own responsibility*


Jest
----

`Jest <https://facebook.github.io/jest>`_ - a new power-horse for testing. Currently I'm using Phantomjs + Mocha + Chai + Sinon for unit and module testing. Casper.js comes to do the functional tests. It works very well, you can get a basic impression about this bundle at `Quick Start Guide <https://medium.com/caffeine-and-testing/testing-with-mocha-chai-sinon-quick-start-guide-12f3e47b1a79>`_. Since my stack is already based on Facebook solutions, *Jest - Painless JavaScript Testing* is a fair update to our stack. It's well integrated, fast and parallelized. It's definitely the next step for the testing stack I would like to upgrade. You may ask - what does it solve? Well - currently only speed. But for long term plan - it solves:

- The upgrade pains - Jest integrates test running, assertions and mocking (so we will rely only one library instead of 3: Mocha, Chai and Sinon)
- Expect better integration with Facebook frameworks.
- Integrates seamlessly with Babel and with TypeScript (ts-jest) and Flow (Babel-jest).
- Immersive Watch Mode - you have to `watch it <https://facebook.github.io/jest/blog/2017/02/21/jest-19-immersive-watch-mode-test-platform-improvements.html>`_

Still not convinced? Watch `Test JavaScript with Jest <https://egghead.io/lessons/javascript-test-javascript-with-jest>`_.



Cypress
-------

`Cypress <https://www.cypress.io/>`_ is another testing framework which integrates the testing process. It's another great update for the standard testing setups, which brings awesome debugging + reporting. Though I'm sold for Jest.


Reason ML
---------

Have you heard about Elm? Now it's time for `Reason <https://facebook.github.io/reason/>`_.

    Reason is a new interface to OCaml - a highly expressive dialect of the ML language featuring type inference and static type checking.
    Reason provides a new syntax and toolchain for editing, building, and sharing code, and will evolve in the open as a community collaboration.


Next.js
-------

Wonder how to speed up React rendering, or create JS-less applications?

`Next.js <https://github.com/zeit/next.js/>`_ is a minimalistic framework for server-rendered React applications.


State in React
--------------

During last year many solutions emerged from the missing strong *default* state management Flux implementation. Market seams a strong adoption for redux. However the evolution hasn't finished. We have new strong player - `MobX <https://mobx.js.org>`_. Currently I'm using our own custom router. I was planning to integrate Redux, however MobX took my attention and the presentation was great. MobX is well designed library based on *Observables*. It's batter tested and it seams to have strong market adoption. Bonus: `mobx-router <https://github.com/kitze/mobx-router>`_ - as well integrated solution for routing in React!



Other interesting libraries
---------------------------

- `react-router <github.com/reacttraining/react-router>`_ -  Declarative routing for React
- `draft.js <https://github.com/facebook/draft-js>`_ - A React framework for building text editors. Directly from FB! If you want to have a reach text fields in React then draft.js is your solution. Bonus: comes with many plugins!
- `markdown-to-react-components <https://github.com/christianalfoni/markdown-to-react-components>`_ Convert markdown into React.
- `react-custom-validation <https://github.com/vacuumlabs/react-custom-validation>`_ - React Validation Library.


Extra
-----

GraphQL
~~~~~~~

GraphQL takes traction. I had a pleasure taking with developers implementing and using GraphQL.


Datomic
~~~~~~~

Have you ever thought about bringing declarative data manipulation into the application? Immutable distributed general-purpose database? Does it make sens?
If you have this questions then have a look at `Datomic <http://www.datomic.com/>`_.
