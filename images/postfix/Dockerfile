FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env value for mysql installer
ENV mysql_installer mysql-server_5.7.16-1ubuntu16.04_amd64.deb-bundle.tar

#Preseed Answers for Postfix
RUN	echo postfix postfix/main_mailer_type        select  Internet Site | debconf-set-selections;\
		echo postfix postfix/mailname        string  jcqac.qac.local | debconf-set-selections; 

#Install postfix silently	
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
		
#Expose mail server port, 25; 110; 143; 465; 587; 993; 995
#25 & 465 & 587 for SMTP
#143 & 993 for IMAP
#110 & 995 for POP3

EXPOSE 25
EXPOSE 110
EXPOSE 143
EXPOSE 465
EXPOSE 587
EXPOSE 993
EXPOSE 995

ENTRYPOINT service postfix start && bash

