# Base Containers

[![Build Status](https://travis-ci.org/GovTechSG/base-images.svg?branch=master)](https://travis-ci.org/GovTechSG/base-images)

This repository is a collection of Docker images we use internally for testing out runtimes/frameworks.

Daily builds are run against these images and automatically sent to our DockerHub repository at:

https://hub.docker.com/r/govtechsg/base-images

## Catalog (Alphabetical Order)

- Node.js (`node-*`)

### Release Notes
The images are found in the [DockerHub registry](https://hub.docker.com/r/govtechsg/base-images), and the names of the different types of images are added as a tag. For example given a type of image called `xyz`, it will be available under the repository URL `govtechsg/base-images:xyz-latest`. Specific versions can be found in the [DockerHub Tags page](https://hub.docker.com/r/govtechsg/base-images/tags/)

### Usage/Description

#### Node 8 (`node-8`)
Canonical Tag: `node-<NODE_VERSION>`  
Latest URL: `govtechsg/base-images:node-8-latest`

##### Notes
Generally compiled Node.js binary that comes with Yarn.

General compilation allows for debugging and performance profiling.

## Other Uses
Images specified here can be uploaded to other repositories if you so wish. The commands are:

### For Building
The build script creates the build for the specified image:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

An example to upload to a DockerHub at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

### For Publishing
The publish script in each directory sends your built image to DockerHub and relies on the `./.scripts/.build.sh` script being run prior to it. The general format of usage:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

A corresponding example to upload to a DockerHub repository at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

Each directory and type of image has its own publish script because of the different ways they are versioned.