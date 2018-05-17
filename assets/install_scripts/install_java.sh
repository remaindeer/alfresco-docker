#!/usr/bin/env sh
set -e

# create java folder
mkdir -p /alfresco/java

# unzip java archive
cd /tmp
tar -xvzf /tmp/jdk-8u111-linux-x64.tar.gz

# move unzipped folder to the created folder
mv /tmp/jdk1.8.0_111/* /alfresco/java/

# Remove temp zip
rm -f /tmp/jdk-8u111-linux-x64.tar.gz
rm -rf /tmp/jdk-8u111-linux-x64
