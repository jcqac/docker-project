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

#Set run_as_user in bash.rc
WORKDIR opt/nexus/bin
RUN echo "run_as_user="nexus"" > ./nexus.rc 

#Setup Nexus user
RUN groupadd nexus &&\
	useradd -g nexus nexus --shell=/sbin/nologin
	
# Install Nexus as a Service
COPY ./nexus.service /etc/systemd/system/
RUN systemctl daemon-reload &&\
	systemctl enable nexus.service &&\
	systemctl start nexus.service
	
	
#Expose Nexus ports
EXPOSE 8081

ENTRYPOINT systemctl start nexus.service

