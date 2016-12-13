FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for mysql installer
ENV mysql_installer mysql-server_5.7.16-1ubuntu16.04_amd64.deb-bundle.tar

#expose volume to host
VOLUME /var/lib/mysql

#Update permissions on /var/lib/mysql
RUN chown mysql /var/lib/mysql\
&& chgrp mysql /var/lib/mysql

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/mysql

	#Setup required dependencies libaio1, libmecab2, perl, psmisc, python, python3
	RUN apt-get update
	RUN apt-get install -y libaio1 libmecab2 perl psmisc python python3

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

	WORKDIR /opt/mysql

#Setup MySQL end ~~

#Expose MySQL port
EXPOSE 3306

#ENTRYPOINT service mysql start && bash
