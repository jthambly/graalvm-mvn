![Docker Build and Push](https://github.com/jthambly/graalvm-mvn/workflows/Docker%20Build%20and%20Push/badge.svg?branch=master)

# graalvm-mvn
Dockerfile for building a GraalVM and Maven image

Source Versions:

GraalVM CE: 21.0.0-java11 <br/>
OpenJDK: Java11 <br/>
Maven: 3.6.3

# Run as user

This container will run as the User 'mvn' and UID of '1000'. <br/>

In running this you may need to make adjustments in either the host filesystem permissions, or build platform, to mount volumes.<br/>

<p>When using Google Cloud Build, the workspace permissions need to be adjusted to allow the mvn user to modify files/folders. <br/>

For example, Allen (2020) provides a means to change the file permissions to allow anyone (in the current build process) to modify files. This allows the container to access and modify workspace files/folders as required.<br/><br/>

References:<br/><br/>

Allen, A. Z. (2020, March 27). Running as a non-root user · Issue #641 · GoogleCloudPlatform/cloud-builders. https://github.com/GoogleCloudPlatform/cloud-builders/issues/641#issuecomment-604599102</p>

# Workspace:

These two locations have been created as an optional workspaces, that is /workspace, and /project. <br/>
You will need to mount your project to one of these, or to another location of your choosing.

# Using an external .m2 repository cache:

To utilise an external .m2 cache location, it can be mounted to the /home/mvn/.m2 location.
