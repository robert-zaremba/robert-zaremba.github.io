Keep your session open
======================

.. author:: default
.. categories:: IT
.. tags:: screen, tmux
.. comments::

.. |br| raw:: html

    <br />

Have you ever thought how to keep session open on remote host, or want to run multiple processes in a background?

You may hear about `nohup <http://en.wikipedia.org/wiki/Nohup>`_, but it is uncomfortable and doesn't allow you to come back to this process.

tmux and screen
###############


Multiplex virtual consoles are the way to go.
Both are well known and widely used in the Linux world.

I prefer tmux. It has more features, is more comfortable and beauty out of the box. According to **tmux** FAQ:

.. more::

*  A clearly defined client/server model (windows are their own clients which allows flexibility on how you handle windows. You can attach and detach different windows in different sessions without any issues)
*  Consistent, well-documented command interface. (You can use the same commands interactively as in the .tmux.conf file, more on that later)
*  Easily scriptable
*  Multiple paste buffers
*  Vi &amp; Emacs keybindings
*  A more usable status line syntax (which also allows you to embed the output of a shell command, handy indeed.


How to start
************

Imagine you are logged in a remote server and want to download big file.
Just enter into virtual console and make the job there::

    tmux
    ## the multiplex will run
    wget http://sever.com/some_file

To go back to main console type: **prefix d** (detach)
Then you can logout, and later log in and type::

    tmux attach

*prefix* is a key combination used to make some actions. By default
**`prefix = Ctrl-b`**
Since in *screen* ``prefix=Ctrl-a``, it is nice to use the same prefix. Moreover, in my opinion, ``Ctrl-a`` is easier to type.
To change the prefix, you need to edit tmux configuration file (``~/.tmux.conf``)

tmux configuration
******************

.. code-block:: sh

    # ~/.tmux.conf
    # remap prefix to Ctrl-a
    set -g prefix c-a
    unbind c-b
    bind c-a send-prefix

    # set vi mode. Enter Ctrl+a [ to navigate like in vi. Enter return to get out of the mode
    setw -g mode-keys vi


    # force a reload of the config file
    unbind r
    bind r source-file ~/.tmux.conf

    # quick pane cycling
    unbind ^a
    bind ^a select-pane -t :.+


Working with tmux
*****************

*  Commands in tmux can be entered from command line: `tmux  <command>`
   your console emulator might support *tab* completion with `tmux <tab>`
*  in tmux session `prefix :`
*  directly using key shortcut (like previously mentioned `prefix-d` to detach)

Session management
------------------

tmux can manage multiple session.

*  ``tmux new -s session_name`` |br|
   creates a new tmux session named session_name
*  ``tmux attach -t session_name`` |br|
   attaches to an existing tmux session named session_name
*  ``tmux switch -t session_name`` |br|
   switches to an existing session named session_name
*  ``tmux list-sessions`` |br|
   lists existing tmux sessions
*  ``tmux detach (prefix d)`` |br|
   detach the currently attached session


Windows and panes
-----------------

In single tmux session you can have multiple windows/tabs. It is very helpful when creating multiple windows to set them names.
On tmux you can divide to multiple panes, each one will be occupied by some window

*  ``tmux new-window [-n window-name] [-t target window] [command]`` *(prefix  c)* |br|
   a new window and optionally run there a command. The *-t* option specify where to put new window (as a which window) - can be in form [session_name:]window_num
*  ``tmux rename-window`` *(prefix  ,)* |br|
   rename the current window
*  ``tmux select-window -t :0-9`` *(prefix  0-9)* |br|
   move to the window based on index
*  ``kill-window`` *(prefix &)* |br|
   kill current window
*  *prefix n / p / l / w* |br|
   move to next / previous / previously selected window / list windows
*  ``find-window`` *(prefix f)* |br|
   find window by name

*  ``tmux split-window`` *(prefix ")* |br|
   splits the window into two vertical panes
*  ``tmux split-window -h`` *(prefix %)* |br|
   splits the window into two horizontal panes
*  ``tmux swap-pane -[UDLR]`` *(prefix { or })* |br|
   swaps pane with another in the specified direction
*  ``tmux select-pane -[UDLR]`` |br|
   selects the next pane in the specified direction
*  ``tmux select-pane -t :.+`` *(prefix o* or *prefix C-a)* |br|
   selects the next pane in numerical order
*  ``tmux display panes`` *(prefix q)* |br|
   Show pane numbers (used to switch between panes)
*  ``move-window [ &minus;d] [ &minus;s src-window] [ &minus;t dst-window]``
*  ``swap-window [ -d] [ -s src-window] [ -t dst-window]``
*  ``break-pane`` |br|
   make your pane into its own window

Other useful
------------

*  *prefix :* |br|
   enter command
*  ``tmux list-keys`` *(prefix ?)* |br|
   lists out every bound key and the tmux command it runs
*  ``tmux list-commands`` |br|
   lists out every tmux command and its arguments
*  ``tmux info`` |br|
   lists out every session, window, pane, its pid, etc.
*  *prefix [* |br|
   to navigate like in *vi*. Enter *return* to get out of the mode

Further reading
***************

*  `tweaking tmux <http://blog.hawkhost.com/2010/07/02/tmux-%E2%80%93-the-terminal-multiplexer-part-2/>`_
*  `key bindings comparison between tmux and screen <http://hyperpolyglot.org/multiplexers>`_

For Screen users
****************

*  `key bindings <http://www.pixelbeat.org/lkdb/screen.html>`_
*  `window title, bars <http://web.mit.edu/gnu/doc/html/screen_9.html>`_
*  `scrolling, copying, opening sessions <http://www.saltycrane.com/blog/2008/01/how-to-scroll-in-gnu-screen/>`_ in screen
*  `key codes <http://www.delorie.com/gnu/docs/screen/screen_62.html>`_ - Input Translation
