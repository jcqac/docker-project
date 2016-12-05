FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for installer location

# Dependencies Start ~~
	#Env variables maven
	ENV mvn_archive apache-maven-3.3.9-bin.tar.gz
	ENV mvn_folder apache-maven-3.3.9

	#Setup required folders
	RUN mkdir /opt/maven

	#Copy Require Binary
	COPY ./${mvn_archive} /opt/maven

	#Setup Java (JRE 7)
	RUN apt-get update
	RUN apt-get install -y openjdk-8-jre-headless

	#Setup Maven
	WORKDIR /opt/maven
	RUN tar -xvzf ${mvn_archive}
	
	RUN mv ./${mvn_folder} ./m2
	
	RUN update-alternatives --install /usr/bin/mvn mvn /opt/maven/m2/bin/mvn 100
	RUN update-alternatives --display mvn
	
	#set environment variables
	COPY ./environment /etc/
	RUN chown root:root /etc/environment
	RUN chmod 644 /etc/environment
	
	#install daemon
	RUN apt-get install -y daemon
	
	#install psmisc
	RUN apt-get install -y psmisc
	
	#install net-tools
	RUN apt-get install -y net-tools

# Dependencies end ~~

# Install Jenkins start ~~
	RUN mkdir /opt/jenkins
	ENV jenkins_installer jenkins_2.7.4_all.deb
	WORKDIR /opt/jenkins
	
	#Copy Jenkins installer
	COPY ./${jenkins_installer} /opt/jenkins
	
	#Install Jenkins
	RUN dpkg -i ${jenkins_installer}
	
	#Run Jenkins
	RUN service start jenkins
# Install Jenkins end ~~
	
#Expose Jenkins' port

EXPOSE 8080
	
	