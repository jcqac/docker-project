FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env variables for java
ENV java_archive jdk-8u112-linux-x64.tar.gz
ENV java_folder jdk1.8.0_112

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

