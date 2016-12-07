FROM jc-sql-base
MAINTAINER Johnny Che <johnny.che@qa.com>
#This dockerfile uses apt - manual installation never worked properly

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
	#PHP 7
	RUN apt-get install -y apache2 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-cli php7.0-json php7.0-mysql php7.0-cgi php7.0-xml php7.0-bcmath php7.0-mbstring wget
	
# Dependencies setup end ~~

# Start Zabbix setup ~~
	#make opt folder
	RUN mkdir /opt/zabbix
		
	#Install Zabbix from repo
	RUN wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.2-1+xenial_all.deb
	RUN dpkg -i zabbix-release_3.2-1+xenial_all.deb
	RUN apt-get update -y
	RUN apt-get install -y zabbix-server-mysql zabbix-frontend-php
	
	WORKDIR /opt/zabbix
	
	#This sets up default database for Zabbix
	RUN service mysql start &&\
		zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql zabbixdb -u zabbix --password=G4lacT1ca &&\
		service mysql stop
	
	#This is to set the timezone in php.ini for zabbix to work.
	#Finds the line with date and repleaces the whole line
	#RUN sed -i 's/\;date\.timezone\ =/date.timezone\ =\ Europe\/London/' /etc/php/7.0/apache2/php.ini
	RUN sed -i 's/\;date\.timezone\ =/date.timezone\ =\ UTC/' /etc/php/7.0/apache2/php.ini
	
	#This is to make zabbix run using php7 rather than relic php5
	#RUN service zabbix-server restart &&\
	#	systemctl enable zabbix-server &&\
	#	sed -i s/mod_php5.c/mod_php7.c/ /etc/zabbix/apache.conf 
	
	#Copy server config file
	#COPY ./zabbix_server.conf /etc/zabbix
	RUN \
	sed -i '/# DBHost=/c\DBHost=localhost' zabbix_server.conf &&\
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