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

#Setup TomCat ~~
	#Setup TomCat
	WORKDIR /opt
	RUN tar -xvzf ${tcat_archive}
	RUN mv ./${tcat_folder} ./tomcat
	
#Create Tomcat group and user
RUN groupadd tomcat
RUN useradd -s /sbin/nologin -g tomcat -d /opt/tomcat/temp tomcat

#update permissions of tomcat & folder ownership
RUN	chown -R tomcat:tomcat /opt/tomcat

# Install tomcat as a Service init.d
	#Copy init script
	COPY ./tomcat /etc/init.d
	#Set permissions of init.d tomcat
	RUN chmod 755 /etc/init.d/tomcat
	WORKDIR /etc/init.d
	RUN update-rc.d tomcat defaults
	
	#Run tomcat as the user tomcat
	USER tomcat
	RUN service tomcat start
	
# tomcat as a service end
#Setup TomCat end ~~
	
#Expose TomCat ports
EXPOSE 8080

#Start TomCat
ENTRYPOINT service tomcat start && bash