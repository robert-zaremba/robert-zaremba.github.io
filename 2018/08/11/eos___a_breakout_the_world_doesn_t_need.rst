EOS - a breakout the world doesn't need
=======================================



.. author:: default
.. categories:: none
.. tags:: blockchain, IT
.. comments::

After spending a time digging into EOS, looking at the community and researching all pros & cons for using EOS as the blockchain platform, I come into following conclusions.

EOS.IO is a great piece of technology and amazing experiment to make a "global computer" working. It's uber challenging to design and came across the Decentralized Ledger Technology to provide a secure and trustless settlement platform for transaction operations. Let's have a look if EOS solves that problem.

.. more::


Does it solves our problems?
----------------------------

The best use of blockchain is to solve only the critical part of our IT systems related to trust.

Let's demystify EOS to see if EOS solves that problem well.

Single, secure, immutable source of truth
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

EOS Block Producers can tamper the data.

Decentralization and Governance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ethereum is all about community and distributed work, openness and collaboration.

EOS is all about Block Producers, who enhance the network and try their best to keep their position as a Block Producer.

Ethereum has a wide community and is very open with what it does. It's really targeting collaboration.

EOS has a voting system to choose the Block Producers who manage the system, and can do whatever they want (risking their credibility). BPs process all transactions and earn EOS tokens produced by inflation. The total inflation of EOS tokens is reportedly 5 percent, only 1 percent of which goes to BPs.
BPs are selected by voting events - each EOS holder can vote or delegate their vote to select a BPs.

**Flaw one: exchange centralization**. Cryptocurrency exchange Bitfinex secured its position as a block producer allegedly due to the votes of just few EOS holders, one of which accounted for 27 percent of all votes for Bitfinex.

**Flaw two: ‘Mutual voting’** It implies a process when block producers are voting for each other in order to remain in power and keep their passive income - according to some estimations, top three EOS BPs earn around 1000 EOS per day.

Vitalik Buterin, truthfully criticized the EOS governance model:

  “As a followup, *this* is why I do not believe in coinholder-voted on-chain treasuries. Any chain where coinholder-voted on-chain issuance is used to supposedly fund public goods can easily collapse into this kind of ‘I vote for your crappy project, you vote for mine’ equilibrium.”


[UPDATE]
Most recent EOS Constitution violence. As explained in the following `Reddit post <https://www.reddit.com/r/ethereum/comments/bcoxv9/eos_constitution_changed_by_block_producers/>`_, a new version of Constitution was maliciously approved:

+ There was a proposed change to the constitution of EOS that was taking too long to get approved.
+ There was only ~1.7% of the of the tokens voting but for a change to pass it requires a sustained 15% of the tokens voting.
+ Because the community wasn't voting the Block Producers took it upon themselves to approve the measure (which is out of the scope of their duties) because they claim that token holders (who have already shown an indifference to this whole voting thing) can just stop delegating to their Block Producer if they don't like the outcome of this decision.


Smart-Contractes vs Ordinary Services
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

EOS tries to mark itself as a platform which can potentially handle most of the use-cases in layer-1 level. Hence, EOS.io attempts to represent a decentralized alternative to cloud hosting services.
We all know the CAP theorem. You can't have everything in distributed systems: Consistency, Availability, Partition Tolerance. Now if you add execution performance, the polarity to one of C,A,P will be even stronger. The EOS is semi-centralized solution based on several dozne of data centers. As the core of the system offers lot of service (computational and memory wise), it means that the entry point is very high. Combined with *Decentralization* issue described above, the overall platform will stick to a narrow group of Block Producers.

Cartels
-------

Together, the high entry point (to be a BP), voting issue and concentration of power support the Cartel bodies. Although this kind of collusion is against the EOS constitution, the system itself doesn't protect against such behavior and EOS can repeat what happened to Lisk.

You can see the voting distribution using a great website: `eosauthority <https://eosauthority.com/voting>`_.

According to statistics from Etherscan, the top 100 EOS accounts collectively own 75 percent of the 1 billion EOS tokens. The top 10 accounts own 50 percent of all tokens. Block producers already hold enormous power. EOS is governed by a plutocracy of super-rich accounts. One of the powers block producers have is to blacklist and freeze accounts, thus giving the BPs the ability to delay access to the network to opponents. If all 21 block producers collude this would effectively freeze an account, censoring them from participation in the network.

What’s worse is that these same block producers could file arbitration claims against opponents. All a block producer would need is to produce an anonymous account and file an arbitration claim against an opponent. Then, as the case is getting adjudicated upon the funds are typically frozen by the arbitrator; effectively silencing an opponent.


Conclusions
-----------

Do we need a global computer with big capabilities? **NO**.

Blockchain is becoming an indispensable technology. But EOS won't fit into it. It's one more cool experiment, which doesn't solve the major problems. We don't need a world computer. We need **trustless, decentralized, complient** smart-contracts.


References
----------

[UPDATED]


+ `Is the Ethereum team defending their ground against claim by EOS? <https://www.reddit.com/r/ethereum/comments/6qm0y2/is_the_ethereum_team_defending_their_ground/>`_.
+ `EOS: Governance issues explained and the current state of affairs <https://medium.com/@LindaCrypto/eos-governance-issues-explained-and-the-current-state-of-affairs-75d2847ee8b9>`_ - analysis of the first (after EOS public release) governance failure.
+ `Everything they don’t want you to know about EOS <https://hackernoon.com/everything-they-dont-want-you-to-know-about-eos-the-ethereum-killer-9939c43aa2df>`_.
+ `Ethereum 2.0 vs EOS <https://www.reddit.com/r/ethereum/comments/9zsequ/ethereum_20_vs_eos/>`_.
+ `EOS Community Is Challenged After Node Announces Financial Rewards for Votes <https://cointelegraph.com/news/eos-community-is-challenged-after-node-announces-financial-rewards-for-votes>`_.
+ `EOS faces 6 major problems, according to new study <https://www.chepicap.com/en/news/6529/eos-faces-6-major-problems-according-to-new-study.html>`_ (in Chinees).
