FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for nexus archive
ENV nex_archive nexus-3.1.0-04-unix.tar.gz
ENV nex_folder nexus-3.1.0-04

#Global Env values
ENV NEXUS_HOME="/opt/nexus"

#Dependencies Start ~~
	#Copy required files
	COPY ./${nex_archive} /opt
#Dependencies End ~~

#Setup Nexus ~~
	#Setup Nexus
	WORKDIR /opt
	RUN tar -xvzf ${nex_archive}
	RUN mv ./${nex_folder} ./nexus

#Setup Nexus end ~~

##Setup Nexus user
#RUN useradd -M nexus &&\
#	usermod -L nexus &&\
#	chown -R nexus:nexus /opt/nexus
RUN groupadd nexus
RUN useradd -s /sbin/nologin -g nexus -M nexus
	
#update permissions of nexus & folder ownership
WORKDIR opt/nexus/bin
RUN	chown -R nexus:nexus /opt/nexus
RUN chown -R nexus:nexus /opt/sonatype-work
RUN chmod a+x /opt/nexus/bin/nexus

#Set run_as_user in nexus.rc
RUN /bin/bash -c "echo run_as_user='\"nexus\"' > /opt/nexus/bin/nexus.rc"
	
# Install Nexus as a Service init.d
	RUN ln -s ${NEXUS_HOME}/bin/nexus /etc/init.d/nexus
	RUN update-rc.d /etc/init.d/nexus defaults
	
	#Run nexus as the user nexus
	USER nexus
	RUN service nexus start
# Nexus as a service end
	
#Expose Nexus ports
EXPOSE 8081

ENTRYPOINT service nexus start && bash