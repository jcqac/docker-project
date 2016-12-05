FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>


#Env value for tomcat archive
ENV tcat-archive apache-tomcat-9.0.0.M13.tar.gz
ENV tcat-folder apache-tomcat-9.0.0.M13

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/tomcat

	#Copy required files
	COPY ./${tcat-archive} /opt/tomcat
#Dependencies End ~~

#Setup TomCat ~~
	
	#Setup TomCat
	WORKDIR /opt/tomcat
	RUN tar -xvzf ${tcat-archive}
	RUN mv ./${tcat-folder} ./apache-tomcat
	
	#Copy initialisation script
	COPY ./tomcat /etc/init.d
	RUN chmod 755 /etc/init.d/tomcat

#Setup TomCat end ~~

#Start TomCat
	RUN /etc/init.d/tomcat start
	
#Expose TomCat ports
EXPOSE 8080


