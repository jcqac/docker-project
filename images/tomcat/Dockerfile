FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for tomcat archive
ENV tcat_archive apache-tomcat-9.0.0.M13.tar.gz
ENV tcat_folder apache-tomcat-9.0.0.M13

#Global ENV .e.g CATALINA_HOME
ENV CATALINA_HOME /opt/${tcat_folder}

#Dependencies Start ~~
	#Copy required files
	COPY ./${tcat_archive} /opt
#Dependencies End ~~
	
#Create Tomcat group and user
RUN groupadd tomcat
RUN useradd -s /sbin/nologin -g tomcat -d ${CATALINA_HOME}/ tomcat

#Setup TomCat ~~
	#Setup TomCat
	WORKDIR /opt
	RUN chown tomcat:tomcat ${tcat_archive}
	RUN tar -xvzf ${tcat_archive}

#update permissions of tomcat & folder ownership
WORKDIR ${CATALINA_HOME}
RUN rm -rf logs/
RUN mkdir logs/
RUN	chown -R tomcat:tomcat ${CATALINA_HOME}
RUN chmod -R 755 ${CATALINA_HOME}
RUN chown -R tomcat:tomcat webapps/ temp/ logs/ work/ conf/
RUN chmod -R 755 webapps/ temp/ logs/ work/ conf/

#update permissions of tomcat shell scripts
WORKDIR ${CATALINA_HOME}/bin
RUN chmod ug+x *.sh

# Install tomcat as a Service init.d
	#Copy init script
	COPY ./tomcat /etc/init.d
	
	#update init script $CATALINA_HOME
	WORKDIR /etc/init.d
	RUN sed -i "/CATALINA_HOME=pathhere/c\CATALINA_HOME=${CATALINA_HOME}" ./tomcat
	
	#Set permissions of init.d tomcat
	RUN chmod 755 ./tomcat
	RUN update-rc.d tomcat defaults
	
	#Run tomcat as the user tomcat
	USER tomcat
	RUN service tomcat start
	
# tomcat as a service end
#Setup TomCat end ~~

# Create tomcat manager login
RUN sed -i '22i <role rolename="manager-gui"/>' ${CATALINA_HOME}/conf/tomcat-users.xml
RUN sed -i '23i <user username="tomcat" password="T0mc4t" roles="manager-gui"/>' ${CATALINA_HOME}/conf/tomcat-users.xml

#Expose TomCat ports
EXPOSE 8080

#Start TomCat
ENTRYPOINT service tomcat start && bash