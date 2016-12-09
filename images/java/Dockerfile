FROM ubuntu:16.04
MAINTAINER Johnny Che <johnny.che@qa.com>

#Env variables for java installation
ENV java_archive jdk-8u112-linux-x64.tar.gz
ENV java_folder jdk1.8.0_112

#Global ENV for Java e.g. JAVA_HOME
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/java/${java_folder}/bin:/opt/java/${java_folder}/db/bin:/opt/java/${java_folder}/jre/bin"
ENV J2SDKDIR="/opt/java/${java_folder}"
ENV J2REDIR="/opt/java/${java_folder}/jre"
ENV JAVA_HOME="/opt/java/${java_folder}"
ENV DERBY_HOME="/opt/java/${java_folder}/db"

#Setup required folders
RUN mkdir /opt/java

#Copy Require Binary
COPY ./${java_archive} /opt/java

#Setup Java
WORKDIR /opt/java
RUN tar -xvzf ${java_archive}

RUN update-alternatives --install /usr/bin/java java /opt/java/${java_folder}/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /opt/java/${java_folder}/bin/javac 100

RUN update-alternatives --display java