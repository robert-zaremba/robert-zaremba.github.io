Gunicorn and uWSGI with PyPy
============================


.. author:: default
.. categories:: none
.. tags:: none
.. comments::



Below the table presents benchmark results. The numbers are requests / sec (higher result is better). For case I made 3 tests, and set the mean value of them. For PyPy tests were preceded by  with warm up.

Tests are done using `weighttp <http://redmine.lighttpd.net/projects/weighttp/wiki>`_ benchmark tool, which is much more convenient than apache *ab*::

     weighttp -n 10000 -c 200 -t 3 -k "http://127.0.0.1:8000/"


===============      ===========  =======
 X                   CPython 2.7  PyPy 2b
===============      ===========  =======
gunicorn -w 1        2500         6000
gunicorn -w 2        3580         9800
gunicorn -w 3        3600         8000
gunicorn -w 4        3000         8000
gunicorn -w 6        2100         6100
-----------------------------------------
tests -n 10000 -c 100
gunicorn -w 2        4960         11200
-----------------------------------------
gunicorn with tornado and tests -n 10000 -c 200
-----------------------------------------
gunicorn -w 2        7000         23000
===============      ===========  =======


In the first section of the table gunicorn was set with default sync worker, which is a buildin pure python simple http server.
This server is susceptible for clogging - sometime it falls down, don't clean socket descriptor, and fail all subsequent requests (both in PyPy and CPython).
With tornado worker I haven't noticed such behaviour. All goes well and fast.

From the table we can conclude, that in my system configuration there is no point to run more than 2 workers. For the production deployment it you should count your processes (eg other workers, system daemons, DB) and compre the result with available cores. Running too much workers doesn't brings better performance.
Also you need to make sure if your app is CPU intensive or IO. If it's CPU intensive then there is no need to make more workers then the number of available cores (I would advice to make even less, to leve some for system and other processes). If your app is IO intensive than the best is to use asynchronous web server and inside your app use asynchronous IO operations. If this is not possible then you can increase the number of workers beyond the number of available cores.
