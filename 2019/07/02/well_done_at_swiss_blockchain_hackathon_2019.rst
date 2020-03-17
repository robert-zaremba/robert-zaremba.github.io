Well done at Swiss Blockchain Hackathon 2019
============================================



.. author:: default
.. categories:: none
.. tags:: blockchain, hackathon
.. comments::

.. |br| raw:: html

    <br />

.. image:: https://i.imgur.com/trciq2q.jpg
           :align: center
           :class: title


Note on my `Facebook <https://www.facebook.com/notes/robert-zaremba-information-technology-expert/well-done-at-swiss-blockchain-hackathon-2019/2788490227833879/>`_.

SBHack 2019 was amazing. Great atmosphere, energizing people.
I was building a team for my ongoing project: a next-level (legal) contract management system (more info about the project later).

I was super happy to build a rock start team! So let me start with a short team description.

.. more::

Awesome Team

+ `Nicolas Berlinger <https://www.linkedin.com/in/nicolasberlinger/>`_, team role: Innovation Management. |br|
  Nic is Social Entrepreneur, who works at the F10 FinTech Incubator and accelerator.
+ `Patrick Wolleb <https://www.linkedin.com/in/patrickwolleb/>`_, team role: Pipeline Master, AWS magician. |br|
  Agile software engineer with extensive experience delivering robust applications across the stack.
+ `David Duran <https://www.linkedin.com/in/david-duran-bb2036189/>`_, team role: Front-end Dev, master of the wallets. |br|
  Aspiring Computer Science student, next great developer.
+ `Matt Lanfear <https://www.linkedin.com/in/mlanfear>`_, team role: Advisor and coach. |br|
  Finance professional and business transformation consultant working with financial institutions, and startups.
+ (myself) Robert Zaremba: team captain, concept, back-end & blockchain.

.. figure:: https://i.imgur.com/vlGrxGO.jpg

   team at work


SBHACK project
--------------

The demo was created during the 48hours given to each team at Trust Square's `#SBHACK19 <https://www.facebook.com/hashtag/sbhack19?source=note&epa=HASHTAG>`_ - the biggest Swiss Blockchain Hackathon 2019.

The Sequenz demo provides state of the art digital identity verification, streamlined online contract review and an electronic handshake signed on the blockchain. Our solution will be an integrated framework used to define and manage the complex and simple agreement process, verified signatures and KYC module.

Why?
~~~~

We identified  and validated the following problems the business is facing today:

+ Problem 1 - Lack of trustless, secure and auditable solutions for digital contract management.
+ Problem 2 - Lack of secure and auditable delegation options for digital contract management.
+ Problem 3 - Lack of user-friendly solutions for digital contract management.
+ Problem 4 - Risk of loss of paper-based contracts and secure storage requirements for sensitive contracts are costly.

How?
~~~~

We solved this by providing a secure alternative to DocuSign, an service with 100mln users that provides electronic signature technology and digital transaction management for facilitating electronic exchanges of contracts and signed documents. Yet the sole proof of identity within the DocuSign platform are the users' email addresses. In addition, the electronic exchange of contracts and signed documents on DocuSign is not subject to any form of integrity verification, opening the door to document forgery.

After having generated an identity and built a Claim Type(CTYPE) using `Kilt <http://kilt.io/>`_ blockchain, the user can delegate mandatory signatures for the verification of a document.

It’s worth noting that our platform doesn’t change the document (as opposed to DocuSign) and everyone knowing the signatory public key can independently validate signatures.

Positioning
~~~~~~~~~~~

Avoid competition, leverage API opportunities between platforms, provide tools which work for existing market participants.

System components
~~~~~~~~~~~~~~~~~

+ `Go <https://golang.org/>`_ backend server
+ `React <https://reactjs.org/>`_ frontend App
+ `GraphQL <https://graphql.org/>`_ API server
+ `ArangoDB <https://www.arangodb.com/>`_ -- database
+ `æternity <http://aeternity.com/>`_ -- blockchain
+ `Kilt <http://kilt.io/>`_ -- Identity Provider


Blockchain Motivation
*********************

We selected æternity for the following reasons:

+ We can register Oracles on the blockchain. Oracles are first class citizens of the blockchain - Smart Contracts can contact them!
+ Speed / cost efficiency. æternity handles dozens (10k+) TPS!
+ æternity creates new smart contract solutions that are easy to program and formally verifiable, with provable security properties that meet industry expectations for efficiency and reliability. Sophia - æternity smart contract language is OCaml based language with advanced provability and reliability features.

Special thanks
--------------

+ Trust Square for hosting us
+ All sponsors and partners
+ Kilt for knowledge share, especially to `Timo Welde <https://www.linkedin.com/in/timo-welde-5012397b/>`_.
+ Ozan Polat -- for a great spirit.

Videos:

+ https://www.facebook.com/robert.zaremba.scale.it/videos/335877773969449/
+ https://www.facebook.com/robert.zaremba.scale.it/videos/2502932776437551/

.. image:: https://i.imgur.com/6r0sCTK.jpg
.. image:: https://i.imgur.com/pmQPAci.jpg
.. image:: https://i.imgur.com/KRilsWs.jpg
