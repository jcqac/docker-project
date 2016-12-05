FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for installer location
ENV insloc ../bins

# Dependencies Start ~~
	#Env variables java 7
	ENV java_archive jdk-7u80-linux-x64.tar.gz
	ENV java_folder jdk1.7.0_80

	#Env variables maven
	ENV mvn_archive apache-maven-3.3.9-bin.tar.gz
	ENV mvn_folder apache-maven-3.3.9

	#Setup required folders
	RUN mkdir /opt/java
	RUN mkdir /opt/maven

	#Copy Require Binary
	COPY ${insloc}/${java_archive} /opt/java
	COPY ${insloc}/${mvn_archive} /opt/maven

	#Setup Java
	WORKDIR /opt/java
	RUN tar -xvzf ${java_archive}
	
	RUN mv ./${java_folder} ./jvm

	RUN update-alternatives --install /usr/bin/java java /opt/java/jvm/bin/java 100
	RUN update-alternatives --install /usr/bin/javac javac /opt/java/jvm/bin/javac 100

	RUN update-alternatives --display java
	
	

	#Setup Maven
	WORKDIR /opt/maven
	RUN tar -xvzf ${mvn_archive}
	
	RUN mv ./${java_folder} ./m2
	
	RUN update-alternatives --install /usr/bin/mvn mvn /opt/maven/m2/bin/mvn 100
	RUN update-alternatives --display mvn
	
	#set environment variables
	COPY ./environment /etc/
	RUN chown root:root /etc/environment
	RUN chmod 644 /etc/environment

# Dependencies end ~~

# Install Jenkins start ~~
	RUN mkdir /opt/jenkins
	ENV jenkins_installer jenkins_2.7.4_all.deb
	WORKDIR /opt/jenkins
	
	#Copy Jenkins installer
	COPY ../bins/${jenkins_installer} /opt/jenkins
	
	#Install Jenkins
	RUN dpkg -i ${jenkins_installer}
	
	#Run Jenkins
	RUN service start jenkins
# Install Jenkins end ~~
	
#Expose Jenkins' port

EXPOSE 8080
	
	