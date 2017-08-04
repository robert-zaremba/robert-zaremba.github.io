How to add GPS (geolocation) tags to photos
===========================================

.. author:: default
.. categories:: IT
.. tags:: geolocation
.. comments::


There are a lot of web services which read the metadata from pictures and display them. Among doses metadata are those to store gps coordinates. Some services use them to present the location, where a picture was taken.
The usually metadata info are stored is `EXIF <http://en.wikipedia.org/wiki/Exchangeable_image_file_format>`_ which is one of the popular by camera manufactures and web services. There are also other standards, but not such popular or quiet old.

.. more::

Nowadays some of the cameras and a lot of mobiles have a gps module, so the can put geolocation information to picture in the moment it is taken.

But what if we have a pictures without geolocation information? I thought there are be a lot of free Linux programs to put this information into picture.
But I spend some hours to look for them. I couldn't find comfortable easy, small application which adds geolocation to picture!

.. raw:: html

  <h4>Application for exif metadata present, or to allow edit only the most popular</h4>

*  gwenview (present all included information, but allow to edity only the mos popular keys, but not the ones from geolocation)
*  digiKam / showFoto - only present the metadata
*  gthum - only present the metadata
*  gimp - don't allow to present / edit metadata unless without special plugin (I didn't check). What is worse it delete metadata information from picure!

.. raw:: html

  <h4>Application for adding automaticly geolocation info from gps log file (gpx).</h4>

After googleing for "how to add geolocation / geodata / geocalucus to picture" I found some programs that read the gps logs, check the catalogue, look for appropriate pictures and update geolocation info.
The problem is that

#.  you need to have gps log file.
#.  Ok, you can make some file - this requires additional work, and to learn how this file looks like.
#.  the pictures timestamp must correspond to timestamp from gps log file! Those tools check if picture was taken in a similar time gps log a position.

So it can be quiet problematic. But the applications are:

#.  gpicsync
#.  gpscorrelate

.. raw:: html

  <h4>Application that allow handy put geolocation into picture.</h4>

Finaly I found some of them:

#.  exiv2 (command line)
#.  exiftool (command line)
#.  gexif

The best are those command line - they allow to easy scripting!

As noted by `Darek <http://disqus.com/derekc6o/>`_ to make your GPS geolocation usefull you should specify following data:

* longitude degrees + direction ref (north or south)
* latitude  degrees + direction ref (east or west)

Example of using exiftool
*set longtitude latitude with exiftool*

.. code-block:: bash

    % exiftool -GPSLongitude="14.273586"  -GPSLatitude="50.860361" img.png

Example of using exiv2

.. code-block:: bash

    ## print summary of image metadata (default behaviour when we run: exiv2 img.jpg)
    % exiv2 pr -p s img.jpg

    ## print all metadata from img
    % exiv2 pr -p a img.jpg

    ## extract GPS info
    % exiv2 pr -p a img.jpg  | grep GPS

    ## set image latitude to 14.12213 deg == 14deg 16' 24.910", we need to put 3 vaules of type <natural_val/1[0*number of digits after dot -1]>
    % exiv2 -M"set  Exif.GPSInfo.GPSLatitude 1412213/100000 0/1 0/1" -M"set Exif.GPSInfo.GPSLatitudeRef N" img.jpg

    ## set image latitude to 14deg 16' 24.910"
    % exiv2 -M"set  Exif.GPSInfo.GPSLatitude 14/1 16/1 24910/1000" -M"set Exif.GPSInfo.GPSLatitudeRef N" img.jpg

    ## loop throug all files in current catalogue and set set both latitude and longtitude to 14deg 16' 24.910"
    % for f in *.jpeg; do
        exiv2 -M"set  Exif.GPSInfo.GPSLatitude 1412213/100000 0/1 0/1" -M"set Exif.GPSInfo.GPSLatitudeRef N" -M"set  Exif.GPSInfo.GPSLongitude 1412213/100000 0/1 0/1" -M"set Exif.GPSInfo.GPSLongitudeRef E" $f;
      done


The list of *exiv2 supported metadata keys* is at http://www.exiv2.org/tags.html
