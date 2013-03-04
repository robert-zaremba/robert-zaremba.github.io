Emacs on fly syntax checking for Go programming language
========================================================

.. author:: default
.. categories:: programming
.. tags:: go, emacs
.. comments::

Emacs is a great, flexible editor. `Go <http://golang.org/>`_ is quiet new powerful programming language.
There are a lot of blog posts about pros of both Emacs and Go.

Out of the box, configured Emacs looks like text editor for geeks. To make it more useful you need to spent a little of time and turn on some functions. One of the most desirable features for programmers is syntax checking, so the programmer don't need to make to much edit-save-compile cycles.

Standard Emacs has Flymake built in package. But it is not fashionable. It's generic and useful, but it's configuration is awkward. To add syntax checking for buffers (emacs name for a file content) you need to write fight with Elisp (the script language in which Emacs is written).

But there is also Flycheck - new package which supersede Flymake. *Essentially it's “flymake done right”*.
If you are not familiar with it, I encourage you to read more on `Flycheck project site <https://github.com/lunaryorn/flycheck>`_ and use it. Flycheck requires Emacs >= 24.

Back to the topic. Adding on fly syntaxt checking for Go programming language is relatively simple.
Presented solutions are pure syntax checkers. They don't compile or make cross modules checking.


Using Flycheck
**************

.. highlight:: cl

Flycheck makes it simple - you need to declare new checker and add it to checkers list. The *checker declaration* is described in the source of Flycheck:
``checker_symbol_name doc_string properties``. Properties is a sequence of ``:property value`` pairs.

The declaration should be in ``eval-after-load`` statement, to execute it only when it's needed - when editing go files. Below is the final code, you need to add to your *.emacs* file::

    (eval-after-load "go-mode"
      '(progn
         (flycheck-declare-checker go-fmt
           "A Go syntax and style checker using the gofmt utility."
           :command '("gofmt" source-inplace)
           :error-patterns '(("^\\(?1:.*\\):\\(?2:[0-9]+\\):\\(?3:[0-9]+\\): \\(?4:.*\\)$" error))
           :modes 'go-mode)
         (add-to-list 'flycheck-checkers 'go-gofmt)))

And activate Flycheck by either by manually or with hook for *go-mode*::

    (add-hook 'go-mode-hook 'flycheck-mode)

I will try make push-request to add the code for Flycheck package, so you will not need absolutely nothing when using Flycheck.

Update
------

The pull request was accepted. Now you can update your package (either through `Melpa <http://melpa.milkbox.net>`_ package repository, or `Flycheck project site <https://github.com/lunaryorn/flycheck>`_ project site) and add a hook for go-mode:



Using Flymake
*************

If you are forced to use Emacs < 24, or don't want to use Flycheck then I prepared package for Flymake - *flymake-go*.
It is *package.el* compatible and distributed by *MELPA*

The instruction is available on `flymake-go site <https://github.com/robert-zaremba/flymake-go>`_.

With this package it is super easy.

goflymake
---------

There is also `goflymake <https://github.com/dougm/goflymake>`_ which is more then syntax checking. It uses *go build* tool to perform checking, so it covers also additional type and cross modules checking. But it requires additional wrapper around *go* command. More about it on link above.
