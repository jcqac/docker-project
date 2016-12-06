FROM jc-sql-base
MAINTAINER Johnny Che <johnny.che@qa.com>

ENV zabsrv-installer zabbix-server-mysql_3.2.1-1+xenial_amd64.deb
ENV zabfro-installer zabbix-frontend-php_3.2.1-1+xenial_all.deb


#MySQL DB setup  ~~
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
	#Setup MySQL tables end ~~
#MySQL DB setup end ~~

#Start Setup of Zabbix Server & Zabbix PHP frontend ~~
	#Zabbix Dependencies - PHP & Apache2
	RUN apt-get update
	RUN apt-get install -y apache2 libapache2-mod-php php-bcmath php-mbstring php7.0-xml php-cli php-mcrypt php-mysql
# Dependencies setup end ~~

# Start Zabbix setup ~~
	#make opt folder
	RUN mkdir /opt/zabbix
	#Copy Zabbix installers 
	COPY ./${zabsrv-installer} /opt/zabbix
	COPY ./${zabfro-installer} /opt/zabbix
	
	#Install Zabbix debs
	WORKDIR /opt/zabbix
	RUN dpkg -i ${zabsrv-installer}
	RUN dpkg -i ${zabfro-installer}
	
	#This is to make zabbix run using php7 rather than relic php5
	RUN service zabbix-server restart &&\
		systemctl enable zabbix-server &&\
		sed -i s/mod_php5.c/mod_php7.c/ /etc/zabbix/apache.conf 
		
	#This sets up default database for Zabbix
	RUN zcat /usr/share/doc/zabbix-server-mysql-3.2.1/create.sql.gz | mysql -uzabbix --password=G4lacT1ca
	
	# This is to set the timezone in php.ini for zabbix to work.
	RUN sed -i 's/\;date\.timezone\ =/date.timezone\ =\ Europe\/London/' /etc/php/7.0/apache2/php.ini
	
	#This is to stop the apache service in order to start it on entry
	RUN service apache2 stop
	
# End Zabbix setup ~~

#Expose MySQL port
EXPOSE 3306
#Expose HTTP/S ports
EXPOSE 80
EXPOSE 443
#Expose Zabbix Port
EXPOSE 10051

ENTRYPOINT service apache2 start && service zabbix-server start && bash

