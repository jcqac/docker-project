#!/bin/bash

chown mysql /var/lib/mysql
chgrp mysql /var/lib/mysql
service mysql start

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql -sfu root --password=root < /opt/mysql/tmp/post_install.sql
fi
