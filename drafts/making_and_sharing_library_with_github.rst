Making and sharing library with github
======================================

.. author:: default
.. categories:: IT
.. tags:: Python
.. comments::


Hera I present a tutorial for makeing repository and a web page of your library (the place where you can share and publish your texts)

The steps:

* prepare the repository
* write a scipt which will compile your text
* prepare site style

Dependencies
############

Python, doctils and pygments package.
Docutils is a powerfull `reStructuredText http://docutils.sf.net/rst.html`_ processor written in python. It's a little more verbose than *markdown* but allows for more things. Furthermore Github also allows to present reStructuredText in directly in compiled format.
`Pygments <http://www.pythonware.com/products/pil/>`_ is a generic syntax highlighter, which can highlight your code in a bunch of formats (console, html, latex...). Pygments can be used by docutils to enhance your code snippets.

You can obtain dependencies for Arch Linux by ``sudo pacman -S python-docutils python-pygments`` or install it with **pip**::

    sudo pip install docutils pygments

`More info <http://docutils.sourceforge.net/README.html>`_ about installing docutils.


Prepare the repository
######################

Login to your github account and create new repo with https://github.com/new . You can call it library. You can tick *Initialize this repository with a README* and choosing Python from the list.

Clone the repository to your local copy, and create *gh-pages* branch ::

    git clone git@github.com:<your_username>/library.git
    cd library
    git fetch origin
    git checkout gh-pages
    git push origin gh-pages

The page lives in http://<your_username>.github.com/library/
