FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for tomcat archive
ENV tcat_archive apache-tomcat-9.0.0.M13.tar.gz
ENV tcat_folder apache-tomcat-9.0.0.M13

#Global ENV .e.g CATALINA_HOME
ENV CATALINA_HOME="/opt/tomcat"

#Dependencies Start ~~
	#Copy required files
	COPY ./${tcat_archive} /opt
#Dependencies End ~~

#Create Tomcat group and user
RUN groupadd tomcat
RUN useradd -s /sbin/nologin -g tomcat -d /opt/tomcat tomcat

#Setup TomCat ~~
	#Setup TomCat
	WORKDIR /opt
	RUN tar -xvzf ${tcat_archive}
	RUN mv ./${tcat_folder} ./tomcat
	
	#Copy initialisation script
	#COPY ./tomcat /etc/init.d
	#RUN chmod 755 /etc/init.d/tomcat

#Setup TomCat end ~~
	
#Expose TomCat ports
EXPOSE 8080

#Start TomCat
ENTRYPOINT /opt/tomcat/apache-tomcat/bin/startup.sh && bash

