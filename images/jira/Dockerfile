FROM jc-java-base
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for jira installer
ENV jira_installer atlassian-jira-software-7.2.4-x64.bin

#Dependencies Start ~~
	#Setup required folders
	RUN mkdir /opt/jira

	#Copy JIRA installer
	COPY ./${jira_installer} /opt/jira
	
	#Copy Answer File
	COPY response.varfile /opt/jira
	
	#Assign file permissions
	WORKDIR /opt/jira
	RUN chmod a+x ./${jira_installer}
	RUN chmod 777 ./response.varfile	
	
#Dependencies End ~~

#Setup Jira ~~
	#Setup Jira
	RUN ./${jira_installer} -q -varfile /opt/jira/response.varfile
#Setup Jira end ~~

#Expose Jira ports
EXPOSE 8080 8005

#Run JIRA on entry
ENTRYPOINT service jira start && bash
