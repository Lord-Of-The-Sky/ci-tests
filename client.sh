#!/bin/sh
#
# Environment variables used:
#  - SERVER: hostname or IP-address of the NFS-server
#  - EXPORT: NFS-export to test (should start with "/")
# if any command fails, the script should exit
set -e
# enable some more output
set -x
[ -n "${SERVER}" ]
[ -n "${EXPORT}" ]
# install build and runtime dependencies
yum -y install git gcc nfs-utils time
# checkout the connectathon tests
git clone git://git.linux-nfs.org/projects/steved/cthon04.git
cd cthon04
make all
# v3 mount
mkdir -p /mnt/Ambar
mount -t nfs -o vers=3 ${SERVER}:${EXPORT} /mnt/Ambar
./server -a -p ${EXPORT} -m /mnt/Ambar ${SERVER}
