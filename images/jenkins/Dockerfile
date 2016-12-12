FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env maven archives
ENV mvn_archive apache-maven-3.3.9-bin.tar.gz
ENV mvn_folder apache-maven-3.3.9

#Jenkins installer
ENV jenkins_installer jenkins_2.7.4_all.deb

#Env global variables for maven
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/java/${java_folder}/bin:/opt/java/${java_folder}/db/bin:/opt/java/${java_folder}/jre/bin:/opt/maven/${mvn_folder}/bin"
ENV M2_HOME="/opt/maven/${mvn_folder}"

# Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/maven

	#Copy Require Binary
	COPY ./${mvn_archive} /opt/maven

	#install dependencies: daemon, psmisc, net-tools, openjdk-8-jre-headless(Jenkins complains otherwise)
	#install apt-utils
	RUN apt-get update
	RUN apt-get install -y daemon psmisc net-tools openjdk-8-jre-headless

	#Setup Maven
	WORKDIR /opt/maven
	RUN tar -xvzf ${mvn_archive}

	RUN update-alternatives --install /usr/bin/mvn mvn /opt/maven/${mvn_folder}/bin/mvn 100
	RUN update-alternatives --display mvn
# Dependencies end ~~

# Install Jenkins start ~~
	RUN mkdir /opt/jenkins
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