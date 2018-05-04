#!/usr/bin/env sh
set -e

# Make alfresco user owner
chown -R alfresco.alfresco /alfresco/

# Alfresco permissions
chmod 744 /alfresco/alfresco.sh
chmod 744 /alfresco/init.sh

# set tomcat permissions
chmod 744 /alfresco/tomcat/bin/catalina.sh
chmod 744 /alfresco/tomcat/bin/daemon.sh
chmod 744 /alfresco/tomcat/bin/setclasspath.sh
chmod 744 /alfresco/tomcat/bin/configtest.sh
chmod 744 /alfresco/tomcat/bin/shutdown.sh
chmod 744 /alfresco/tomcat/bin/startup.sh
chmod 744 /alfresco/tomcat/bin/tool-wrapper.sh
chmod 744 /alfresco/tomcat/bin/version.sh
