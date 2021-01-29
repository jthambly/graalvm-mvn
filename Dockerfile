FROM registry.access.redhat.com/ubi8/ubi:8.3
MAINTAINER Jason Hambly www.linkedin.com/in/jason-hambly

# External package versions
ENV GRAALVM_VERSION=21.0.0
ENV OPENJDK_VERSION=11
ENV MAVEN_VERSION=3.6.3

# Environment variables
ENV JAVA_HOME="/opt/graalvm-ce-java$OPENJDK_VERSION-$GRAALVM_VERSION"
ENV MAVEN_HOME="/opt/apache-maven-$MAVEN_VERSION"
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

# Update system packages
RUN yum -y update \
  && yum -y install gcc glibc-devel zlib-devel libstdc++-static

# Download GraalVM CE
RUN curl -s -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" -o "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" \
  && curl -s -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256" -o "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256" \
  && echo "$(cat graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256)  graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" | sha256sum -c

# Extract GraalVM CE
RUN tar -xzf "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" -C /opt

# Install native-image
RUN gu install native-image

# Download Maven
RUN curl -s -L "https://maven.apache.org/download.cgi?action=download&filename=maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -o "apache-maven-$MAVEN_VERSION-bin.tar.gz" \
  && curl -s -L "https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512" -o "apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512" \
  && echo "$(cat apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512)  apache-maven-$MAVEN_VERSION-bin.tar.gz" | sha512sum -c

# Extract Maven
RUN tar -xzf "apache-maven-$MAVEN_VERSION-bin.tar.gz" -C /opt

# Clean up
RUN yum clean all \
  && rm -f graalvm-ce-*.tar.gz* \
  && rm -f apache-maven*.tar.gz*
  