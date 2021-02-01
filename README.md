![Docker Build and Push](https://github.com/jthambly/graalvm-mvn/workflows/Docker%20Build%20and%20Push/badge.svg?branch=master)

# graalvm-mvn
Dockerfile for building a GraalVM and Maven image

Source Versions:

GraalVM CE: 21.0.0-java11 <br/>
OpenJDK: Java11 <br/>
Maven: 3.6.3

# Run as user

This container will run as the user 'mvn' and UID of '1000'. <br/>

In running this you may need to make adjustments in either host filesystem permissions, or build platform.<br/>
When using Google Cloud Build, the workspace permissions need to be adjusted to allow the mvn user to modify files/folders. <br/>

<p>
For example, this solution (..,..) changes the file permissions are changed to allow anyone (in the current build process) to modify files.<br/><br/>

References:<br/><br/>

..<br/>
..
</p>

# Workspace:

These two locations have been created as an optional workspaces, that is /workspace, and /project. <br/>
You will need to mount your project to one of these, or to another location of your choosing.

# Using an external .m2 repository cache:

To utilise an external .m2 cache location, it can be mounted to the /home/mvn/.m2 location.
