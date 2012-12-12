Jabber client behind firewall and proxy
=======================================

.. author:: default
.. categories:: IT
.. tags::  jabber, proxy
.. comments::


There is a great article explaining how to setup jabber client to connect to jabber server which is outside firewall: https://web.amessage.eu/firewalled

Behind the scene, if your jabber server don't support connection through 80/443 port, then you can:

#.  register new account on jabber80.com
#.  Most of the desktop clients support automatic account registration.
#.  install a client that support proxy connection (vacuum-im, psi)
#.  manage a account to connect through proxy (need to know the company proxy)
#.  use ``jabber80.com:443`` as a  server to connect to.

The company I work for uses firewall that block everything besides HTTP :80/443 and proxy to manage outside connection.

I succeed with setup my desktop client to jabber.wp.pl and talk.google servers.

talk.google
-----------

The configuration for google talk is as follows (for vacuum-im):

#.  set your credentials (username@gmail.com)
#.  enable and configure the proxy server (the one you use to connect to internet)
#.  tick "Use legacy SSL connection"
#.  manually set the host: talk.google.com   port: 443 or 80

| The standard configuration for jabber at talk.google is described on `google support pages <http://support.google.com/talk/bin/answer.py?hl=en&answer=24074&topic=1415&ctx=topic>`_
| [Edit]
| Recently I read that google also `uses 5222 port <http://support.google.com/talk/bin/answer.py?hl=en&answer=27930>`_!

There is also solution with proxytunel, described `here <http://vnoel.wordpress.com/2008/01/30/google-talk-in-ichat-behind-a-firewall/>`_. I didn't try this.

Left with
---------

Since I normally don't use google account, and my primary jid is at jabber.org; I was forced to use my previous solution - jabber web client which is bundled into mail service I use (zoho.com). Generally all web clients works fine (assuming the proxy is configured correctly).

Other good topics and answers you can find at: http://www.softwaretalk.info/google-talk/
