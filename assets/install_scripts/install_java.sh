#!/usr/bin/env sh
set -e

# create java folder
mkdir -p /alfresco/java

# unzip java archive
cd /tmp
tar -xvf /tmp/jdk1.8.0_65.tar

# move unzipped folder to the created folder
mv /tmp/jdk1.8.0_65/* /alfresco/java/

# Remove temp zip
rm -f /tmp/jdk1.8.0_65.zip
rm -rf /tmp/jdk1.8.0_65
