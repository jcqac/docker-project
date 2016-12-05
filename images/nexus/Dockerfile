FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for installer location
ENV insloc ../bins

#Env value for nexus archive
ENV nex-archive nexus-3.1.0-04-unix.tar.gz
ENV nex-folder nexus-3.1.0-04

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/nexus

	#Copy required files
	COPY ${insloc}/${nex-archive} /opt/nexus
#Dependencies End ~~

#Setup Nexus ~~
	
	#Setup Nexus
	WORKDIR /opt/nexus
	RUN tar -xvzf ${nex-archive}
	#RUN mv ./${nex-folder} ./nexus3

#Setup Nexus end ~~

#Start TomCat
	WORKDIR /opt/nexus/${nex-folder}
	RUN nexus start
	
#Expose Nexus ports
EXPOSE 8081


