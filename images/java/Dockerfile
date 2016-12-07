FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env variables for java installation
ENV java_archive jdk-8u112-linux-x64.tar.gz
ENV java_folder jdk1.8.0_112

#Global ENV for Java e.g. JAVA_HOME
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/java/jvm/bin:/opt/java/jvm/db/bin:/opt/java/jvm/jre/bin"
ENV J2SDKDIR="/opt/java/jvm"
ENV J2REDIR="/opt/java/jvm/jre"
ENV JAVA_HOME="/opt/java/jvm"
ENV DERBY_HOME="/opt/java/jvm/db"

#Setup required folders
RUN mkdir /opt/java

#Copy Require Binary
COPY ./${java_archive} /opt/java

#Setup Java
WORKDIR /opt/java
RUN tar -xvzf ${java_archive}

RUN mv ./${java_folder} ./jvm

RUN update-alternatives --install /usr/bin/java java /opt/java/jvm/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /opt/java/jvm/bin/javac 100

RUN update-alternatives --display java

# Set Java home environments
COPY ./environment /etc/
RUN chown root:root /etc/environment
RUN chmod 644 /etc/environment


