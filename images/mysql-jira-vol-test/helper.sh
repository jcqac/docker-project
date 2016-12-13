#!/bin/bash
	
service mysql start

if [ ! -d /var/lib/mysql/jiradb ]; then
	mysql -sfu root --password=root < "/opt/mysql/tmp/post_install.sql"
fi
