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
RUN groupadd nexus
	useradd -s /sbin/nologin -g nexus -d /path/to/nexus nexus
	
	
# Install Nexus as a Service
COPY ./nexus.service /etc/systemd/system/
RUN systemctl daemon-reload &&\
	systemctl enable nexus.service &&\
	
#Expose Nexus ports
EXPOSE 8081

ENTRYPOINT systemctl start nexus.service

