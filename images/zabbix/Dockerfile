FROM jc-mysql-base
MAINTAINER Johnny Che <johnny.che@qa.com>

ENV zabsrv_installer zabbix-server-mysql_3.2.1-1+xenial_amd64.deb
ENV zabfro_installer zabbix-frontend-php_3.2.1-1+xenial_all.deb

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
		service mysql stop &&\
		rm -rf /opt/mysql/tmp
		
		WORKDIR /opt/mysql
	#Setup MySQL tables end ~~
#MySQL DB setup end ~~

#Start Setup of Zabbix Server & Zabbix PHP frontend ~~
	#Zabbix Dependencies - PHP & Apache2
	RUN apt-get update
	
	#zabbix server dependencies
	RUN apt-get install -y apache2 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-cli php7.0-json php7.0-mysql php7.0-cgi php7.0-xml php7.0-bcmath php7.0-mbstring php-mysql
	RUN apt-get install -y libcurl3 libiksemel3 libodbc1 libopenipmi0 libsnmp30 libssh2-1 fping libcurl3-gnutls snmpd traceroute snmptrapd logrotate
	
	#zabbix frontend dependencies
	RUN apt-get install -y php-gd php-ldap ttf-dejavu-core
# Dependencies setup end ~~

# Start Zabbix setup ~~
	#make opt folder
	RUN mkdir /opt/zabbix
	#Copy Zabbix installers 
	COPY ./${zabsrv_installer} /opt/zabbix
	COPY ./${zabfro_installer} /opt/zabbix
	
	#Install Zabbix debs
	WORKDIR /opt/zabbix
	RUN dpkg -i ${zabsrv_installer}
	RUN dpkg -i ${zabfro_installer}
	
	#This sets up default database for Zabbix
	RUN service mysql start &&\
		zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql zabbixdb -u zabbix --password=G4lacT1ca &&\
		service mysql stop
		
	#This is to set the timezone in php.ini for zabbix to work.
	#Finds the line with date and repleaces the whole line
	RUN sed -i 's/\;date\.timezone\ =/date.timezone\ =\ UTC/' /etc/php/7.0/apache2/php.ini
	
	#This is to make zabbix run using php7 rather than relic php5
	RUN service zabbix-server restart &&\
		systemctl enable zabbix-server &&\
		sed -i s/mod_php5.c/mod_php7.c/ /etc/zabbix/apache.conf
	
	# Modifies zabbix_server.conf so that it is able to run.
	WORKDIR /etc/zabbix
	RUN sed -i '/# DBHost=/c\DBHost=localhost' zabbix_server.conf &&\
	sed -i '/DBName=zabbix/c\DBName=zabbixdb' zabbix_server.conf &&\
	sed -i '/# DBPassword=/c\DBPassword=G4lacT1ca' zabbix_server.conf &&\
	sed -i '/# DBPort=/c\DBPort=3306' zabbix_server.conf
	
	#This is to stop the apache service in order to start it on entry
	RUN service apache2 restart && service zabbix-server restart
	
# End Zabbix setup ~~
#Expose MySQL port
EXPOSE 3306
#Expose HTTP/S ports
EXPOSE 80
EXPOSE 443
#Expose Zabbix Port
EXPOSE 10051

ENTRYPOINT service mysql start && service apache2 start && service zabbix-server start && bash
#ENTRYPOINT bash
