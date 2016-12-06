FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for installer location

#Env value for mysql installer
ENV mysql_installer mysql-server_5.7.16-1ubuntu16.04_amd64.deb-bundle.tar

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/mysql
	RUN mkdir /opt/mysql/tmp
	COPY ./post_install.sql /opt/mysql/tmp

	#Setup required dependencies
	RUN apt-get update
	RUN apt-get install -y libaio1
	RUN apt-get install -y libmecab2
	RUN apt-get install -y perl
	RUN apt-get install -y psmisc
	RUN apt-get install -y python
	RUN apt-get install -y python3
	RUN apt-get install -y apt-utils

	#Copy required files
	COPY ./${mysql_installer} /opt/mysql
#Dependencies End ~~

#Setup MySQL ~~
	#Extract MySQL
	WORKDIR /opt/mysql/
	RUN tar -xvf ${mysql_installer}

	#preseed answers
	RUN	echo mysql-community-server  mysql-community-server/root-pass password root | debconf-set-selections;\
		echo mysql-community-server  mysql-community-server/re-root-pass password root | debconf-set-selections;

	#Install SQL Server community edition
	WORKDIR /opt
	RUN DEBIAN_FRONTEND=noninteractive dpkg -R --install mysql/

	#Execute SQL statement to setup accounts and relavent tables.
	WORKDIR /opt/mysql/tmp
	RUN mysql -sfu root --password=root < "post_install.sql"

	#Copy config over
	COPY ./mysqld.cnf /etc/mysql/mysql.conf.d/

	#Remove tmp folders
	RUN rm -rf /opt/mysql/tmp
#Setup MySQL end ~~

#Expose MySQL port
EXPOSE 3306

