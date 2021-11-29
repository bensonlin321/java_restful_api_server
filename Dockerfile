From ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin
EXPOSE 8888 22 443 8080

#ENV M2_HOME=/opt/maven
#ENV MAVEN_HOME=/opt/maven
ENV KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
ENV JAVA_HOME=/usr/lib/jdk1.8.0_211
ENV PATH=$PATH:$JAVA_HOME/bin
#ENV PATH=$PATH:$JAVA_HOME/bin:$M2_HOME

# ssh for debugging
RUN mkdir /temp && mkdir /temp/install && apt-get update && apt-get install -y git curl wget openssh-server sudo vim
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd # sets the password for the user test to test

# install java
WORKDIR /temp/install
RUN wget https://github.com/frekele/oracle-java/releases/download/8u211-b12/jdk-8u211-linux-x64.tar.gz
RUN tar -zxvf jdk-8u211-linux-x64.tar.gz
RUN cp -R /temp/install/jdk1.8.0_211 /usr/lib/jdk1.8.0_211
RUN ln -s /usr/lib/jdk1.8.0_211/bin/java /etc/alternatives/java
RUN apt-get install -y maven

# web terminal
WORKDIR /temp
