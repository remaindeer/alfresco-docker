#!/usr/bin/env sh
set -e

# create java folder
mkdir -p /alfresco

# unzip java archive
cd /tmp
unzip /tmp/alfresco-one-distribution-5.1.2.zip

# move unzipped folder to the created folder
mv /tmp/alfresco-one-distribution-5.1.2/* /alfresco/

# Remove temp zip
rm -f /tmp/alfresco-one-distribution-5.1.2.zip
rm -rf /tmp/alfresco-one-distribution-5.1.2

# install amps
export JAVA_HOME=/alfresco/java
/alfresco/java/bin/java -jar /alfresco/bin/alfresco-mmt.jar install /alfresco/amps /alfresco/tomcat/webapps/alfresco.war -directory -force -nobackup -verbose
/alfresco/java/bin/java -jar /alfresco/bin/alfresco-mmt.jar install /alfresco/amps_share /alfresco/tomcat/webapps/share.war -directory -force -nobackup -verbose