FROM debian:buster-slim
MAINTAINER Jason Hambly www.linkedin.com/in/jason-hambly

# External package versions
ENV GRAALVM_VERSION=21.3.0
ENV OPENJDK_VERSION=17
ENV MAVEN_VERSION=3.8.4

# Environment variables
ENV JAVA_HOME="/opt/graalvm-ce-java$OPENJDK_VERSION-$GRAALVM_VERSION"
ENV MAVEN_HOME="/opt/apache-maven-$MAVEN_VERSION"
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

# Update system packages
# Red Hat Quarkus Dependencies - https://quarkus.io/guides/building-native-image

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install build-essential libz-dev zlib1g-dev curl \
  && apt-get -y autoremove \
  && apt-get -y clean

# Download and Install GraalVM CE
# Oracle GraalVM Documentation: https://www.graalvm.org/docs/getting-started/linux/

RUN curl -s -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" -o "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" \
  && curl -s -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256" -o "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256" \
  && echo "$(cat graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz.sha256)  graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" | sha256sum -c \
  && tar -xzf "graalvm-ce-java$OPENJDK_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz" -C /opt \
  && gu install native-image \
  && rm -f graalvm-ce-*.tar.gz*

# Download and Install Maven
# Apache Maven Documentation: https://maven.apache.org/install.html

RUN curl -s -L "https://maven.apache.org/download.cgi?action=download&filename=maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -o "apache-maven-$MAVEN_VERSION-bin.tar.gz" \
  && curl -s -L "https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512" -o "apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512" \
  && echo "$(cat apache-maven-$MAVEN_VERSION-bin.tar.gz.sha512)  apache-maven-$MAVEN_VERSION-bin.tar.gz" | sha512sum -c \
  && tar -xzf "apache-maven-$MAVEN_VERSION-bin.tar.gz" -C /opt \
  && rm -f apache-maven*.tar.gz*

# Set workspace
RUN mkdir /workspace \
  && ln -s /workspace /project
WORKDIR /workspace

# Run as new user
RUN useradd -s /sbin/nologin -m mvn
RUN chown mvn:mvn /workspace
USER mvn

# Default Entrypoint
ENTRYPOINT ["mvn"]
CMD ["--version"]