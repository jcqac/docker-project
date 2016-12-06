FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for nexus archive
ENV nex_archive nexus-3.1.0-04-unix.tar.gz
ENV nex_folder nexus-3.1.0-04

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/nexus

	#Copy required files
	COPY ./${nex_archive} /opt/nexus
#Dependencies End ~~

#Setup Nexus ~~
	
	#Setup Nexus
	WORKDIR /opt/nexus
	RUN tar -xvzf ${nex_archive}
	#RUN mv ./${nex_folder} ./nexus3

#Setup Nexus end ~~

#Start TomCat
	WORKDIR /opt/nexus/${nex_folder}
	RUN nexus start
	
#Expose Nexus ports
EXPOSE 8081


