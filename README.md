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

# Licenses

Debian (base image) - https://www.debian.org/social_contract#guidelines https://github.com/docker-library/repo-info/tree/master/repos/debian<br/>
Oracle GraalVM Community Edition - Sub Licences - https://github.com/oracle/graal/#license<br/>
OpenJDK - https://openjdk.java.net/legal/gplv2+ce.html<br/>
Apache Maven - https://www.apache.org/licenses/LICENSE-2.0 https://github.com/docker-library/repo-info/tree/master/repos/maven<br/>
Red Hat Quarkus - https://www.apache.org/licenses/LICENSE-2.0<br/>
<p>
In terms of locally created files:<br/>
<br/>
Copyright 2021 Jason Hambly<br/>
<br/>
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:<br/>
<br/>
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.<br/>
<br/>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</p>