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

### `Gravitee` latest before 3

* Check the Hardware n Software requirements below
* Execute this on your Docker Compose Machine :

```bash
export DESIRED_VERSION=feature/initalisation-du-code
export DESIRED_VERSION=feature/reproducing-bug-for-issue-1

git clone git@github.com:pegasus-io/this-is-gravitee.git

cd this-is-gravitee/

git checkout ${DESIRED_VERSION}

./reproduce_gravitee_latest_before_3.sh

```

### `Gravitee` release 3

* Check the Hardware n Software requirements below
* Execute this on your Docker Compose Machine :

```bash
export DESIRED_VERSION=feature/initalisation-du-code
export DESIRED_VERSION=feature/reproducing-bug-for-issue-1

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

# Gravitee 3

Gravitee 3 release brings a new architecture, with 4 instead of 3 components , for `Gravitee APIM` : https://docs.gravitee.io/apim/3.x/apim_installguide.html

* There is no `2.x` release of `Gravitee APIM` , just a `1.x`, and a leap to `3.x` :
* There is a `2.x` release of `Gravitee AM` , not just a `1.x`, and also a `3.x` :

![Official Gravitee Site](https://github.com/Jean-Baptiste-Lasselle/for-fellow-developers/raw/master/docuementation/impr.ecrans/gravitee/GRAVITEE_AM_MAJOR_SEMVERSIONS_2020-06-02%2012-33-05.png)

* Just before any `3.x` release, the `lastest` docker images allowed me therefore to successfully provision a `Gravitee` Fullstack including `Gravitee APIM 1.x (latest)` and `Gravitee AM 2.x (latest)`
* Since `3.x` release brings in breaking changes, especially for the management APIs, I will stick to stack with versions `Gravitee APIM 1.x (latest)` and `Gravitee AM 2.x (latest)`.
* As for the `Gravitee APIM` images, the `tag` is not the only part of the docker images 's `GUN` (a sort of UUID for docker images, Global Unique Name. So that keepping `latest` tag **does not infer any upgrade to `Gravitee APIM` version `3.x`, as time goes by.**
* As for the `Gravitee AM` images, the `tag` is indeed, this time, the only part of the docker images 's `GUN` (a sort of UUID for docker images, Global Unique Name. Therefore, keepping `latest` tag **does infer an upgrade to `Gravitee AM` version `3.x`, as time goes by, for the 3 compoants (gateway, ui, management api)**
