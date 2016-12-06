FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for installer location

#Env value for jira installer
ENV jira_installer atlassian-jira-software-7.2.4-x64.bin

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/atlassian/
	RUN mkdir /opt/atlassian/jira

	#Copy required files
	COPY ./${jira_installer} /opt/atlassian/jira
#Dependencies End ~~

#Setup Jira ~~
	
	#Copy Answer File
	COPY ./response.varfile /opt/atlassian/jira
	
	#Setup Jira
	WORKDIR /opt/atlassian/jira
	RUN chmod a+x ./${jira_installer}
	RUN ./${jira_installer} -q -varfile ./reponse.varfile


#Setup Jira end ~~

#Expose Jira ports
EXPOSE 8081
EXPOSE 8006

