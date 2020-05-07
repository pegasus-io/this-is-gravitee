### Hardware Requirements 

Main facts that justify the hardware requirements for this recipe : 
* This recipe will provision All Gravitee Components, in a single one huge docker-compose.
* This recipe will provision Elastic Search, along Gravitee : so we will need some disk space for Elastic Search Data Storage
* This recipe will provision MongoDB as DB for Gravitee data : so we will need some disk space for MongoDB Storage

So the `/var` disk space, must be big (for all the contianers and images pulled an run by the docker-compose)
So the RAM size, must be big enough (top run all those contianers in the docker-compose)

Which is why our recommendations to run this docker-compose, on the hardawre requirements, is to use a virtual machine : 

* with just one big hard drive disk, at least 350 Gb (Virtual machines can have 350 Gb Disks, that actually use a lot less on host, see `Virtual Box` _dynamically allocated virtual disks_, for a simple example)
* Don t use LVM, just install the OS (I used Debian) on the one single, big 350 GB partition on your one and only hard disk drive

* I recommend at least 8GB RAM, I think you can give a try for 6GB of RAM, and I am almost sure you are going to have a hard time at 4 GB of RAM

Et voilà, for the hardware requirements, you are done.

# How to run


