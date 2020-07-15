FROM oracle/graalvm-ce:20.1.0-java11
MAINTAINER Jason Hambly www.linkedin.com/in/jason-hambly

# Update system packages
RUN yum -y update

# Install native-image
RUN gu install native-image

# Download Maven
RUN yum -y install wget
RUN wget https://apache.mirror.digitalpacific.com.au/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
  && wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz.sha512 \
  && sh -c "cat apache-maven-3.6.3-bin.tar.gz.sha512 && echo '  apache-maven-3.6.3-bin.tar.gz'" | sha512sum -c

# Extract Maven
RUN tar -xvf apache-maven-3.6.3-bin.tar.gz -C /opt \
  && ln -s /opt/apache-maven-3.6.3/bin/mvn /usr/local/bin

# Clean up
RUN yum -y erase wget \
  && yum clean all \
  && rm apache-maven*.tar.gz*

# Create new user
RUN useradd -s /sbin/nologin -M mvn

# Run as
USER mvn
