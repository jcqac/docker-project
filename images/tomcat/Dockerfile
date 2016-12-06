FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for tomcat archive
ENV tcat_archive apache-tomcat-9.0.0.M13.tar.gz
ENV tcat_folder apache-tomcat-9.0.0.M13

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/tomcat

	#Copy required files
	COPY ./${tcat_archive} /opt/tomcat
#Dependencies End ~~

#Setup TomCat ~~
	#Setup TomCat
	WORKDIR /opt/tomcat
	RUN tar -xvzf ${tcat_archive}
	RUN mv ./${tcat_folder} ./apache-tomcat
	
	#Copy initialisation script
	COPY ./tomcat /etc/init.d
	RUN chmod 755 /etc/init.d/tomcat

#Setup TomCat end ~~
	
#Expose TomCat ports
EXPOSE 8080

#Start TomCat
ENTRYPOINT /etc/init.d/tomcat start && bash

