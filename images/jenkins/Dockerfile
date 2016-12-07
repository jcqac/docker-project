FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env global variables for maven
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/java/jvm/bin:/opt/java/jvm/db/bin:/opt/java/jvm/jre/bin:/opt/maven/m2/bin"
ENV J2SDKDIR="/opt/java/jvm"
ENV J2REDIR="/opt/java/jvm/jre"
ENV JAVA_HOME="/opt/java/jvm"
ENV DERBY_HOME="/opt/java/jvm/db"
ENV M2_HOME="/opt/maven/m2"

# Dependencies Start ~~
	#Env variables maven
	ENV mvn_archive apache-maven-3.3.9-bin.tar.gz
	ENV mvn_folder apache-maven-3.3.9

	#Setup required folders
	RUN mkdir /opt/maven

	#Copy Require Binary
	COPY ./${mvn_archive} /opt/maven
	
	#install apt-utils
	RUN apt-get update
	#RUN apt-get install -y apt-utils
	
	#install daemon
	RUN apt-get install -y daemon
	
	#install psmisc
	RUN apt-get install -y psmisc
	
	#install net-tools
	RUN apt-get install -y net-tools
	
	#Setup Java (JRE 7)
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

# Dependencies end ~~

# Install Jenkins start ~~
	RUN mkdir /opt/jenkins
	ENV jenkins_installer jenkins_2.7.4_all.deb
	WORKDIR /opt/jenkins
	
	#Copy Jenkins installer
	COPY ./${jenkins_installer} /opt/jenkins
	
	#Install Jenkins
	RUN dpkg -i ${jenkins_installer}
	
# Install Jenkins end ~~
	
#Expose Jenkins' port
EXPOSE 8080
	
#Run jenkins on start
ENTRYPOINT service jenkins start && bash
	