![Docker Build and Push](https://github.com/jthambly/graalvm-mvn/workflows/Docker%20Build%20and%20Push/badge.svg?branch=master)

# graalvm-mvn
Dockerfile for building a GraalVM and Maven image

Source Versions:

GraalVM CE: 21.0.0-java11 <br/>
OpenJDK: Java11 <br/>
Maven: 3.6.3

Using an external .m2 repository cache:

To utilise an external .m2 cache location, it can be mounted to the /home/mvn/.m2 location.