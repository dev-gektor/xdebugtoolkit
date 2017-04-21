#!/bin/bash

OUTPROFAILERDIR=/tmp/profiler
PATTERN='xdebug.profiler_enable'
FILE=/etc/php/7.0/mods-available/xdebug.ini


if [ ! -d "$OUTPROFAILERDIR" ]; then
    mkdir $OUTPROFAILERDIR
    chmod -R 777 $OUTPROFAILERDIR
fi


if grep -q $PATTERN $FILE;
 then
     echo "Profile settings enabled"
 else
 	echo "Profiler settings are not enabled
Recorded new settings"
	echo "zend_extension=xdebug.so
xdebug.profiler_enable = 1
xdebug.profiler_output_dir = '$OUTPROFAILERDIR'" > $FILE
fi

find $OUTPROFAILERDIR -type f -exec rm {} \;

phpenmod xdebug
service apache2 restart
