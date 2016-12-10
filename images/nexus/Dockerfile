FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for nexus archive
ENV nex_archive nexus-3.1.0-04-unix.tar.gz
ENV nex_folder nexus-3.1.0-04

#Global Env values
ENV NEXUS_HOME /opt/${nex_folder}

#Dependencies Start ~~
	#Copy required files
	COPY ./${nex_archive} /opt
#Dependencies End ~~

#Setup Nexus ~~
	#Setup Nexus
	WORKDIR /opt
	RUN tar -xvzf ${nex_archive}

#Setup Nexus end ~~

##Setup Nexus user
	RUN groupadd nexus
	RUN useradd -s /sbin/nologin -g nexus -M nexus
	
#update permissions of nexus & folder ownership
	WORKDIR opt/nexus/bin
	RUN	chown -R nexus:nexus /opt/${nex_folder}
	RUN chown -R nexus:nexus /opt/sonatype-work
	RUN chmod a+x /opt/${nex_folder}/bin/nexus

#Set run_as_user in nexus.rc
	RUN /bin/bash -c "echo run_as_user='\"nexus\"' > /opt/${nex_folder}/bin/nexus.rc"
	
# Install Nexus as a Service init.d
	RUN ln -s ${NEXUS_HOME}/bin/nexus /etc/init.d/nexus
	WORKDIR /etc/init.d
	RUN update-rc.d nexus defaults
	
	#Run nexus as the user nexus
	USER nexus
	RUN service nexus start
# Nexus as a service end
	
#Expose Nexus ports
EXPOSE 8081

ENTRYPOINT service nexus start && bash