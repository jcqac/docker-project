FROM centos
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for IBM UCD zip
ENV ucd_archive URBANCODE_DEPLOY_6.2.2_EN_EVAL.zip
ENV ucd_exfolder ibm-ucd-install
ENV ucd_folder ibm-ucd

#Env value for java RPM
ENV java_archive jdk-8u112-linux-x64.rpm
ENV java_folder jdk1.8.0_112

#Global Env values
ENV JAVA_HOME /usr/java/${java_folder}

#Dependencies Start ~~
	#Copy required files
	COPY ./${ucd_archive} /opt
	COPY ./${java_archive} /opt
	
	#install unzip
	RUN yum check-update
	RUN yum install -y unzip
#Dependencies End ~~

##Setup ucd user
	RUN groupadd ibmucd
	RUN useradd -s /sbin/nologin -g ibmucd -M ibmucd

#Setup begin ~~
	#Setup Java
		WORKDIR /opt
		RUN rpm -ivh ${java_archive}
	#Java end
	
	#Setup IBM UCD
		#Extract IBM archive
		RUN unzip ${ucd_archive}
		WORKDIR /opt/${ucd_exfolder}
	# Copy and modify install.properties to specify silent install
		COPY ./install.properties /opt/${ucd_exfolder}
		RUN sed -i "/install.java.home=path/c\install.java.home=${JAVA_HOME}" install.properties
	
	#For version 6.2.2 - workaround for hanging silent install
		RUN touch workaround.txt
		RUN /bin/bash -c "echo '\"\"' > ./workaround.txt"
	#run install.sh
		#RUN ./install-server.sh
		RUN /bin/bash -c "./install-server.sh < ./workaround.txt"
	#Setup IBM UCD end
	
	#Update /opt/ibm-ucd/bin/init/server user and group
		RUN sed -i '/SERVER_USER=@SERVER_USER@/c\SERVER_USER="ibmucd"' /opt/${ucd_folder}/bin/init/server &&\
		sed -i '/SERVER_GROUP=@SERVER_GROUP@/c\SERVER_GROUP="ibmucd"' /opt/${ucd_folder}/bin/init/server
	#Update end
#Setup end ~~

#update permissions of ibm ucd & folder ownership
	WORKDIR opt/${ucd_folder}/bin
	RUN	chown -R ibmucd:ibmucd /opt/${ucd_folder}
	RUN chmod a+x /opt/${ucd_folder}/bin/init/server
#Update end
	
# Install IBM UCD as a Service init.d
	WORKDIR /etc/init.d
	RUN ln -s /opt/${ucd_folder}/bin/init/server ucdserver
	RUN chkconfig --add ucdserver
	RUN chkconfig --levels 345 ucdserver on
	
	#Run IBM UCD as the user ibmucd
	USER ibmucd
	RUN service ucdserver start
# IBM UCD as a service end
	
#Expose IBM ports
EXPOSE 7918
EXPOSE 8080
EXPOSE 8443

ENTRYPOINT service ucdserver start && bash