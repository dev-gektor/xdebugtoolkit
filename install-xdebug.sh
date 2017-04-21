#!/bin/bash
FILE=/etc/php/7.0/mods-available/xdebug.ini

confirm() {

	echo "Xdebug not installed"
	read -p "Install xdebug? <y/n> " prompt
	if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
	then
	  echo "Yes"
	  apt-get install php-xdebug
	  echo "zend_extension=xdebug.so" > $FILE
	  phpenmod xdebug
	  service apache2 restart
	else
	  echo "error"
	  exit
	fi
}


if php -m  | grep -q "xdebug" 
then
	echo "Xdebug installed - true"	
else
	confirm
fi

exit