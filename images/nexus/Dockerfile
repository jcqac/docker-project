FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for nexus archive
ENV nex_archive nexus-3.1.0-04-unix.tar.gz
ENV nex_folder nexus-3.1.0-04

#Dependencies Start ~~
	#Setup required folders
	#RUN mkdir /opt/nexus

	#Copy required files
	COPY ./${nex_archive} /opt
#Dependencies End ~~

#Setup Nexus ~~
	#Setup Nexus
	WORKDIR /opt
	RUN tar -xvzf ${nex_archive}
	RUN mv ./${nex_folder} ./nexus

#Setup Nexus end ~~

#Setup Nexus user
RUN useradd -M nexus &&\
	usermod -L nexus &&\
	chown -R nexus:nexus /opt/nexus
	
WORKDIR opt/nexus/bin

#Set run_as_user in nexus.rc
RUN /bin/bash -c "echo run_as_user='\"nexus\"' > /opt/nexus/bin/nexus.rc"
	
# Install Nexus as a Service init.d
	#Set environment variable for nexus home
	RUN /bin/bash -c "echo NEXUS_HOME='\"/opt/nexus\"' >> /etc/environment"
	RUN source /etc/environment
	RUN ln -s $NEXUS_HOME/bin/nexus /etc/init.d/nexus
	
	WORKDIR /etc/init.d
	RUN update-rc.d nexus defaults
	RUN service nexus start
# Nexus as a service end
	
#Expose Nexus ports
EXPOSE 8081

ENTRYPOINT service nexus start && bash