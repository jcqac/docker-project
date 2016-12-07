FROM jc-mysql-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Dependencies Start ~~
	RUN mkdir /opt/mysql/tmp

	#Copy required files
	COPY ./post_install.sql /opt/mysql/tmp
#Dependencies End ~~

#Setup MySQL Tables and Users~~
	
	#Execute SQL statement to setup accounts and relavent tables.
	WORKDIR /opt/mysql/tmp
	
	RUN service mysql start &&\
	mysql -sfu root --password=root < "post_install.sql" &&\
	rm -rf /opt/mysql/tmp
	
	WORKDIR /opt/mysql
	
#Setup MySQL end ~~

#Expose MySQL port
EXPOSE 3306

ENTRYPOINT service mysql start && bash

