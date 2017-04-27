Notes: Applied Machine Learning Days 2017
=========================================

.. author:: default
.. categories:: computer_science
.. tags:: machine-learning
.. comments::

This post includes notes from the `Applied Machine Learning Days 2017 <https://www.appliedmldays.org/>`_ conference at `EPFL <https://www.epfl.ch/>`_ which I attended in Jan 2017.

.. more::

The conference focused on applied research and ML usage. Below I present my personal findings. It's not minutes from the conference.

+ Transfer learning gets a big traction in Deep Learning ecosystem. Pete Warden (Google) presented we can specialize image classifier using pre-trained ImageNet model. The source is available in `TensorFlow for poets <https://codelabs.developers.google.com/codelabs/tensorflow-for-poets>`_ repository.

+ Raise of mobile internet was a huge challenge for telecommunication operators. They need to turn their revenue model from GSM calls / SMS into internet services. Claudiu Musat presented new IT direction at Swisscom

  + NLP for customer support. They are navigating support team using NLP, speech recognition and translations (Idiap) to help the _help_ line operator to respond quickly and satisfy customer.
  + new projects with NLP

+ Sentimental analysis is a hot topic (Swisscom, Google, Vodafone, Universities ...).

+ Nadejda Lupolova (University Edinburgh, Roslin) with her talk *"Machine learning applied to microbial genomics: from prediction of infection potential to targeted treatment of bacterial disease"* made a great example how non ML experts are trying to apply ML methods to make things done. They are mining data to find solutions for targetted vaccines. They are looking for expert to help them with research.

+ *"Growing Wikipedia Across Languages via Recommendation"* was a talk by Bob West (EPFL) presenting a classical recommendation problem: find new articles for French Wikipedia based on the pages from other Wikipedia domains (eg English version). The system has a well defined target: recommend pages to existing Wikipedia contributors, which will be happy to add new articles. The main factors for the page recommendation algorithm are: popularity of the article in the foreign version and cultural aspects (eg French people are more likely to write and read about the cheese rather then burrito). The results were backed with the proper A/B tests (carefully selected the test groups) which shows that Wikipedia contributors are more likely to write new articles recommended by the system.

+ Jürgen Schmidhuber (IDSIA) presented the *true* history of AI. "True Artificial Intelligence will Change Everything". Will the learning explosion converge (singularity theory)?

  .. image:: http://i.imgur.com/bC5ZV9q.jpg
     :width: 400

+ Marloes Maathuis (ETH), *"Estimating causal effects from observational data"* talked about difficulties when answering casual questions. She introduced `PC algorithm <http://download.hugin.com/webdocs/manuals/Htmlhelp/descr_PC_algorithm_pane.html>`_ (other nice `source <https://www.stat.cmu.edu/~cshalizi/uADA/12/lectures/ch25.pdf>`_) and it's `R-pcalg` implementation.

  .. image:: http://i.imgur.com/N42s5jf.jpg
     :width: 400

+ Armand Joulin (Facebook) presented `fastText <https://github.com/facebookresearch/fastText>`_ (library for fast text representation and classification) benchmarks (speed and correctness) and Bag of Words idea.

+ Nuria Oliver outlined her research areas: individual modeling, human trait, behavior, business intelligent. The she presented two research projects. First one, crime analysis, tried to map the crime probability on the map of London and conduct police. The main model factors were: people density, diversity and social aspects. Second project was about Board app - a mobile application which detects when we are board (it finds the mobile usage when we are board). The outcome is to recommend something interesting to people who are board (rather then cycle around FB and email box). Last application she didn't have time to present was Credit Inference.

+ Martin Jaggi presented `Distributed Machine Learning Benchmark <https://github.com/mlbench/mlbench>`_ - a public and reproducible comparison of distributed systems.

  .. image:: http://i.imgur.com/tdCUYxJ.jpg
     :width: 400

+ During Panel on AI & Society we touched several interesting areas:

  + social aspects of AI in our life
  + education system is not prepared for AI revolution
  + value of being objective - always explain the baseline

+ Boi Faltings (EPFL) had a nice outline: *"Big data vs. the right data"*


CrowdAI
-------

The conference promoted `CrowdAI <https://www.crowdai.org/>`_ - a new platform for solving ML problems by community. It's a Kaggel competitor by EPFL.

ADA Poster Session
------------------

At the conference hall there was a poster session - highlights of the students ML projects. Two of them payed my attention: Solar Energy Production Forecast and Solar system ROI analysis. Currently I'm developing algorithms to optimize energy flow (exchange, market) in Smart Grids and computing Return of Investment for the Solar and Battery systems in such network. I was very happy to see the projects from the same area from academia - it proves that there is a good market interest!


.. image:: http://i.imgur.com/Crp1mih.jpg
   :width: 400

.. image:: http://i.imgur.com/WeLfa3Y.jpg
   :width: 400
