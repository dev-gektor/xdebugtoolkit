#!/bin/bash

OUTPROFAILERDIR=/tmp/profiler
OUTPROFAILERFILE=/var/www/html/profiler.html

php7dismod xdebug
service apache2 restart

python worker $OUTPROFAILERFILE $OUTPROFAILERDIR

if test -f $OUTPROFAILERFILE; 
then  
	chown www-data:www-data $OUTPROFAILERFILE
else
	echo "File not found";
fi

find $OUTPROFAILERDIR -type f -exec rm {} \;
