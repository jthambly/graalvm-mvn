![Docker Build and Push](https://github.com/jthambly/graalvm-mvn/workflows/Docker%20Build%20and%20Push/badge.svg?branch=master)

# graalvm-mvn
Dockerfile for building a GraalVM and Maven image

Binary Versions:

GraalVM CE: 21.1.0-java16 <br/>
OpenJDK: Java16 <br/>
Maven: 3.8.1

## Running

The default entry point into the container will be maven using the `mvn` command, and by default, the version will be displayed (Example 1).

**Example 1: Running Maven**

`docker run -t --rm --name graalvm-mvn jthambly/graalvm-mvn`

If you want to provide arguments to maven, you can do so easily by appending them to the end (Example 2). *Note: you do not need to include the `mvn` command*.

**Example 2: Running Maven with arguments**

`docker run -t --rm --name graalvm-mvn jthambly/graalvm-mvn --version`

If you would like to run other commands such as `java` or `jar` that are available, you will need to overwrite the entry point (Example 3).

**Example 3: Running other commands**

`docker run -t --rm --name graalvm-mvn --entrypoint java jthambly/graalvm-mvn --version`


## Container user

A running container will be under the user `mvn` with the UID and GID of `1000:1000`.

You will need to take special notice when it comes to the file permissions of mounted volumes. 
The container is running using the `mvn` user. However, a mounted volume will likely take on the permissions of the host, as such may be another user such as `root`. 
Given this, the user may not be able to create folders and write the files required during the building process.

If you have control of the host, it *may* be as simple as adjusting the permissions of the folders you are mounting to be suitable for the `mvn` user (`UID:1000`) of the container.

In other circumstances, you may not have control over the underlying host, for example when you using building platforms such as *Google Cloud Build*. 
A solution for this ([Allen, 2020](https://github.com/GoogleCloudPlatform/cloud-builders/issues/641#issuecomment-604599102)) may be to change the file permissions during a build step to allow anyone (in the current build process) to modify files. 
This allows the container to access and modify the workspace files/folders as required.


References:

Allen, A. Z. (2020, March 27). *[Running as a non-root user](https://github.com/GoogleCloudPlatform/cloud-builders/issues/641#issuecomment-604599102) · Issue #641 · GoogleCloudPlatform/cloud-builders*. https://github.com/GoogleCloudPlatform/cloud-builders/issues/641#issuecomment-604599102

### Running as the root user

If you understand the risks and wish to run the container as the root user, you can use the `rootusr` tagged image.

## Workspaces

Two locations have been created as optional workspaces. These are:
- */workspace*, and 
- */project*. <br/>


You can mount your project to one of these (Example 4), or an alternate location (Example 5) of your choosing.


**Example 4: Mount to a provided workspace**

`docker run -t --rm --name graalvm-mvn --mount type=bind,src=<LOCAL_PROJECT_PATH>,dst=/workspace jthambly/graalvm-mvn clean package -Pnative`

**Example 5: Mount using a custom workspace**

`docker run -t --rm --name graalvm-mvn --mount type=bind,src=<LOCAL_PROJECT_PATH>,dst=<CONTAINER_PROJECT_PATH> jthambly/graalvm-mvn clean package -Pnative -f <CONTAINER_PROJECT_PATH>/pom.xml`

## Using an alternate .m2 repository cache

To utilise an alterntive .m2 cache location, it can be mounted at the */home/mvn/.m2* location (Example 6).


**Example 6: Mount to an alternate maven repository**

`docker run -t --rm --name graalvm-mvn --mount type=bind,src=<LOCAL_M2_PATH>,dst=/home/mvn/.m2 --mount type=bind,src=<LOCAL_PROJECT_PATH>,dst=/workspace jthambly/graalvm-mvn clean package -Pnative`

## Licenses

Debian (base image)
 - https://www.debian.org/social_contract#guidelines
 - https://github.com/docker-library/repo-info/tree/master/repos/debian

Oracle GraalVM Community Edition - Components
 - https://github.com/oracle/graal/#license

OpenJDK
 - https://openjdk.java.net/legal/gplv2+ce.html

Apache Maven
 - https://www.apache.org/licenses/LICENSE-2.0
 - https://github.com/docker-library/repo-info/tree/master/repos/maven

Red Hat Quarkus
 - https://www.apache.org/licenses/LICENSE-2.0

docker/build-push-action
 - https://github.com/docker/build-push-action/blob/master/LICENSE
 - Documentation: https://github.com/docker/build-push-action


---


Copyright 2021 Jason Hambly

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
