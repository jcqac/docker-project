#!/bin/bash

echo mysql-community-server  mysql-community-server/root-pass password root | debconf-set-selections
echo mysql-community-server  mysql-community-server/re-root-pass password root | debconf-set-selections
		
chown mysql /var/lib/mysql
chgrp mysql /var/lib/mysql
service mysql start

if [ ! -d /var/lib/mysql/jiradb ]; then
	mysql -sfu root --password=root < "/opt/mysql/tmp/post_install.sql"
fi
