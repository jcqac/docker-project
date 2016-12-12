FROM jc-mysql-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Dependencies Start ~~
	RUN mkdir /opt/mysql/tmp

	#Copy required files
	COPY ./post_install.sql /opt/mysql/
	
	#Helper checks if volume already has SQL data, if it does then execution of SQL statement is not neccessary.
	COPY ./helper.sh /opt/mysql/
	
#Dependencies End ~~

#Setup MySQL Tables and Users~~
	
	#Execute SQL statement to setup accounts and relavent tables.
	WORKDIR /opt/mysql/tmp
	WORKDIR /opt/mysql
	
#Setup MySQL end ~~

#Expose MySQL port
EXPOSE 3306

ENTRYPOINT\
chown mysql /var/lib/mysql\
&& chgrp mysql /var/lib/mysql\ 
&& ./helper.sh
&& rm -rf /opt/mysql/tmp\
&& bash
