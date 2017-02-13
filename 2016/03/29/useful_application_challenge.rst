Useful application challenge
============================

.. author:: default
.. categories:: design
.. tags:: software-engineering
.. comments::


Every software developer and an application designer is facing over-engineering. Instead of providing a great user experience, over-engineered features frequently are not useful and are missing the deadlines.


What is a useful application?
-----------------------------

When doing software development I like to think that users want crazy applications and complex solution. I tend to believe that the more robust and generic applications is the more useful it is for users. Thankfully this is utterly wrong.

.. more::

Users are expecting a **trust**. They want to be sure that an application is working as it promises, provides correct results and adds some value. Eventually, they want to feel a need for it and have a good experience while using it (smoothness and intuitiveness). Typical user doesn't care if the application do 100 of extra things, or if the application is ready for unknown features.

With a solid trust one can develop any need for users!


How we can develop a trust and a need?
--------------------------------------

Below I'm listing few concepts which are helpful when designing a useful application.

Design for trust
  Follow the Airbnb case study. The application aim is to sell a service which is impossible from the investors point of view: customers private space to host strangers. Stranger = danger, right?
  They had to develop trust so people would like to offer a hosting place. They achieved it by creating a warm, clear, straight-forward and *trusted* design. Right design can overcome adoption difficulties.

Trust challenge
  You need to find out when people will trust your application. What features will make your application that people will not be afraid of using it?

Well designed reputation system
  Following the trust concept - your application need to build a reputation between you and your customers and between the customers. Do you have a comment or rating system? Do you need a moderation for your comments and posts? How is your privacy policy working? How do you ensure that you are serving reliable data? Don't focus on replicating already known solutions. *High reputation beats high similarity*.

Introducing first
  Very important. If a user is not confident and curious about the application he would be more likely to leave it.

Unique data or places to access
  Does your system provides something unique or curious?

Promise of human connection
  If users can build a connections between themselves the system is likely to be used more often. Building meaningful connections is more important then building empty transactions.


Case study - collaborative consumption
--------------------------------------

From Wikipedia: *Collaborative consumption as a phenomenon is a class of economic arrangements in which participants share access to products or services, rather than having individual ownership.*

Today we are living in a hyper-connected world. We are bombarded by tons of information every day. And we are producing and propagating information.

The Guardian article `The rise of collaborative consumption and the experience economy`_ outlines how the sharing economy is building the big global networks. Each of this global businesses relies on the observation that *experience and time are the most precious commodities we have, and that consequently ownership is becoming more irrelevant than ever before*.

Let's think how trust is important in this businesses? How quickly they can fall if they will loos the trust? Or if a new player will appear on the same market with better trust and reputation system?


Case study - don't cross the limits
-----------------------------------

Lately, we were designing a model for the next feature - a lineup reports repository. The business use case is to consume this reports from company partners and display them in our application UI providing very simple filtering utilities. The requirement says: *Consider that our application is a repository of objects. We must display them in our UI ​as it is given​*.
We got several reports, we learned them and started modeling. In the first round we wanted to integrate data from this reports with our domain by normalizing them. Thus we introduced several mappings - tables which will be used to translate their nomenclature to our. Besides, we needed to provide a fallback solutions. I wanted to be consistent across all our application data. Problem was that each report provider has his own way for naming things. The core concept of data delivered by each provider is the same, however it varies in details. Nevertheless we need to display them in the same UI.

It turns out that our initial work was far ahead business expectations. We tried oversee the further integrations which were out of requirements and user didn't care about them. And of course we have a deadline. We over engineered. We started the second round of modeling with a new goals:

* Focus on storing reports in order to quickly handle new providers.
* Easily process latest reports data from providers in order to present them to customers in our UI.

We redefined the model by finding out what is the common base in all reports and what we have to unify to provide required user experience. We removed almost all our mapping tables and hacks. We didn't need fallback solutions. Eventually we made a design which only normalized the critical part of reports and store the rest as it is given. We decrease the expected development time by 50%. The business team was happy. We will use the saved time in the future if we will have a new requirements about analytic we wanted to foresee. Now we are happy that we will easily deliver the solution before the deadline and satisfy our customers who **just want to see the reports**.


.. _The rise of collaborative consumption and the experience economy: http://www.theguardian.com/technology/2014/jan/03/collaborative-consumption-experience-economy-startups.
