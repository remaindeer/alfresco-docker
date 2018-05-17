#!/usr/bin/env sh
set -e

# create tomcat folder
mkdir -p /alfresco/tomcat
mkdir -p /alfresco/tomcat/shared/lib

# unzip tomcat archive
cd /tmp
tar -xvzf /tmp/apache-tomcat-7.0.82.tar.gz

# move unzipped folder to the created folder
mv /tmp/apache-tomcat-7.0.82/* /alfresco/tomcat/

mv -f /tmp/config_files/catalina.properties /alfresco/tomcat/conf 

# Remove temp zip
rm -f /tmp/apache-tomcat-7.0.82.tar.gz
rm -rf /tmp/apache-tomcat-7.0.82
