Hash function benchmark in python
=================================

.. author:: default
.. categories:: computer science
.. tags:: PyPy,  Python,  hash-function,  murmurhash
.. comments::


I got a task to process a documents which might change. So there need to be some worker process which crawl for processed documents, read new version and check the difference. I don’t want to get into details, but there was no point to store whole document, or some part of it to detect if document changed. If it changed it needs to be reprocessed from the beginning.

The simplest solution is to keep hash of the document, and than compare to hash of the new version. If it is different, than document was changed.

There are a lot of hash function. We can divide then into two groups:

*  noncryptographic
*  cryptographic – we have additional requirement – having only hash result must be hard to find a document which hash equals result.

Generally *noncryptographic* functions are faster.

The most well known hash functions are **sha** and **md5**. Since cryptographic wasn’t requirement, I look for others hash functions.

I don’t want to repeat some good texts about hash functions, so i point to two of them:

* `Choosing a Good Hash Function <http://blog.aggregateknowledge.com/2011/12/05/choosing-a-good-hash-function-part-1/>`_
* `A Survey of Hash Functions <http://burtleburtle.net/bob/hash/doobs.html>`_

I think, the best non-cryptographic hash function is `MurmurHash <http://code.google.com/p/smhasher/wiki/MurmurHash>`_ because:

*  it’s darn fast
*  stable
*  used by others (Microsoft, Google)
*  great fraction of keys hashed without collision
*  has good avalanche behavior

Here I present Python (2.7.3) and PyPy (1.8) performance test for some hash functions. The numbers are time execution of the test in seconds

========= ========= ========
method    cpython   pypy 1.8
========= ========= ========
md5       3.495     3.621
mmh3      0.4336    6.186
smhasher  0.4417    5.877
lookup3   1.6933    7.963
pyhash    0.00022   unsupported
========= ========= ========

The test is very simple. It reads some html file (441KB) and just timeit for 4000 times: ::

    import timeit
    from time import time
    from hashlib import md5
    import mmh3     # http://pypi.python.org/pypi/mmh3/2.0
    import smhasher # http://pypi.python.org/pypi/smhasher
    import pyhash   # http://code.google.com/p/pyfasthash/
                    # need to install previously sudo apt-get install libboost-python-dev
    import lookup3

    data = open("ruya.html").read()
    num = 4000
    repeat_n=1
    setup_c="""
    from hashlib import md5
    import mmh3
    import smhasher
    import lookup3
    #import pyhash
    data=open('ruya.html').read()
    """

    print "*"*40
    print "md5:",  timeit.repeat(stmt="md5(data).digest()", setup=setup_c, repeat=repeat_n, number=num)
    print "mmh3:", timeit.repeat(stmt="mmh3.hash_bytes(data)", setup=setup_c, repeat=repeat_n, number=num)
    print "smhasher",  timeit.repeat(stmt="smhasher.murmur3_x64_128(data)", setup=setup_c, repeat=2, number=num)
    print "lookup3",  timeit.repeat(stmt="lookup3.hashlittle(data)", setup=setup_c, repeat=2, number=num)
