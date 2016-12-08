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
RUN useradd -s /sbin/nologin -g tomcat -d /opt/tomcat/ tomcat

#update permissions of tomcat & folder ownership
WORKDIR /opt/tomcat
RUN rm -rf logs/
RUN mkdir logs/
RUN	chown -R tomcat:tomcat /opt/tomcat
RUN chmod -R 770 /opt/tomcat
RUN chown -R tomcat:tomcat webapps/ temp/ logs/ work/ conf/
RUN chmod -R 770 webapps/ temp/ logs/ work/ conf/

#update permissions of tomcat shell scripts
#WORKDIR /opt/tomcat/bin
#RUN chmod uga+x *.sh

# Install tomcat as a Service init.d
	#Copy init script
	COPY ./tomcat /etc/init.d
	#Set permissions of init.d tomcat
	RUN chmod 755 /etc/init.d/tomcat
	WORKDIR /etc/init.d
	RUN update-rc.d tomcat defaults
	
	#Run tomcat as the user tomcat
	#USER tomcat
	RUN service tomcat start
	
# tomcat as a service end
#Setup TomCat end ~~

# Create tomcat manager login
RUN sed -i '22i <role rolename="manager-gui"/>' /opt/tomcat/conf/tomcat-users.xml
RUN sed -i '23i <user username="tomcat" password="s3cret" roles="manager-gui"/>' /opt/tomcat/conf/tomcat-users.xml

#Expose TomCat ports
EXPOSE 8080

#Start TomCat
ENTRYPOINT service tomcat start && bash