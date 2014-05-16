FROM dockerfile/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

# Run apt-get update
RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -f -y -q curl git unzip 

# Install Java
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -f -y -q oracle-java7-installer oracle-java7-set-default

# Inastll Play framework
RUN curl -O http://downloads.typesafe.com/play/2.1.0/play-2.1.0.zip
RUN unzip play-2.1.0.zip
RUN mv play-2.1.0 play

# Clone Yobi
RUN git clone https://github.com/nforge/yobi.git /play/yobi
WORKDIR /play/yobi
RUN ../play compile

# Run Yobi
EXPOSE 9000
ADD ./start.sh /play/yobi/
RUN chmod +x ./start.sh
CMD /bin/bash -c ./start.sh
