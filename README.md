[![Build Status](https://cloud.drone.io/api/badges/pegasus-io/this-is-gravitee/status.svg)](https://cloud.drone.io/pegasus-io/this-is-gravitee)

# Gravitee On Earth

This Recipes helps you quickly provision a Full `Gravitee` API Gateway Stack using `Docker Compose` / `Podman`
* Gravtee AM : 3 components, `web ui`, `api`, `gateway`
* Gravtee APIM : 3 components, `web ui`, `api`, `gateway`
* `Elastic Search` :  Gravtiee audits ...
* `MongoDB` : well Gravitee 's DB'
* `Traefik` as a reverse proxy for all those girls and guys (note this recipe does not cara about load balancing, it is not the point of this work)


# OS compatibility

This Recipes was tested on `Debian`, and should also run with erros on `Darwin` (MAC OS)

# How to run

* Check the Hardware n Software requirements below
* Execute this on your Docker Compose Machine :

```bash
export DESIRED_VERSION=feature/initalisation-du-code

git clone git@github.com:pegasus-io/this-is-gravitee.git

cd this-is-gravitee/

git checkout ${DESIRED_VERSION}

sudo ./operations.sh

```

### Software Requirements

On the machine where you wil run this recipe, must be isntalled :

* `git`
* `docker`
* `docker-compose` :  be careful, if you have a too old docker-compose version, you might have an error, docker-compose will tell you that, just watch its error messages, if any.


### Hardware Requirements

Main facts that justify the hardware requirements for this recipe :
* This recipe will provision All Gravitee Components, in a single one huge docker-compose: a lot of containers, means a lot of RAM needed.
* This recipe will provision Elastic Search, along Gravitee : so we will need some disk space for Elastic Search Data Storage
* This recipe will provision MongoDB as DB for Gravitee data : so we will need some disk space for MongoDB Storage
* So the `/var` disk space, must be big (for all the contianers and images pulled an run by the docker-compose)
* This docker-compose makes use of
* So the RAM size, must be big enough (top run all those contianers in the docker-compose)

Which is why our recommendations to run this docker-compose, on the hardawre requirements, is to use a virtual machine :

* with just one big hard drive disk, at least 350 Gb (Virtual machines can have 350 Gb Disks, that actually use a lot less on host, see `Virtual Box` _dynamically allocated virtual disks_, for a simple example)
* Don t use LVM, just install the OS (I used Debian) on the one single, big 350 GB partition on your one and only hard disk drive

* I recommend at least 8GB RAM, I think you can give a try for 6GB of RAM, and I am almost sure you are going to have a hard time at 4 GB of RAM

Et voilà, for the hardware requirements, you are done.
