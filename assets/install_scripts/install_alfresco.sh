#!/usr/bin/env sh
set -e

# unzip java archive
cd /tmp
unzip /tmp/alfresco-content-services-distribution-5.2.3.zip

# move unzipped folder to the created folder
mv /tmp/alfresco-content-services-distribution-5.2.3/* /alfresco/

# merge the folders
rsync -a /alfresco/web-server/ /alfresco/tomcat/

# delete unnecessary folder
rm -rf /alfresco/web-server/

# Remove temp zip
rm -f /tmp/alfresco-content-services-distribution-5.2.3.zip
rm -rf /tmp/alfresco-content-services-distribution-5.2.3

# install amps
export JAVA_HOME=/alfresco/java
/alfresco/java/bin/java -jar /alfresco/bin/alfresco-mmt.jar install /alfresco/amps /alfresco/tomcat/webapps/alfresco.war -directory -force -nobackup -verbose
# /alfresco/java/bin/java -jar /alfresco/bin/alfresco-mmt.jar install /alfresco/amps_share /alfresco/tomcat/webapps/share.war -directory -force -nobackup -verbose
