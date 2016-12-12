FROM jc-mysql-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Dependencies Start ~~
	RUN mkdir /opt/mysql/tmp

	#Copy required files
	COPY ./post_install.sql /opt/mysql/tmp
	
	#Helper checks if volume already has SQL data, if it does then execution of SQL statement is not neccessary.
	COPY ./helper.sh /opt/mysql/
	RUN chmod a+x ./helper.sh
	
#Dependencies End ~~

#Setup MySQL Tables and Users~~
	
	#Execute SQL statement to setup accounts and relavent tables.
	WORKDIR /opt/mysql/tmp
	WORKDIR /opt/mysql
	
#Setup MySQL end ~~

#Expose MySQL port
EXPOSE 3306

ENTRYPOINT ./helper.sh && rm -rf /opt/mysql/tmp/ && bash
