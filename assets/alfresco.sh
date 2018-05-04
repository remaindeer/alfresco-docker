# Start or stop Alfresco server
# Set the following to where Alfresco is installed
ALF_HOME=/alfresco
cd "$ALF_HOME"
APPSERVER="${ALF_HOME}/tomcat"
ALFDATA="${ALF_HOME}/alf_data"
SOLRSERVER="${ALF_HOME}/solr4"
# Set any default JVM values
export JAVA_HOME=${ALF_HOME}/java
export JAVA_OPTS='-server -Xms2048m -Xmx6144m -XX:NewRatio=2 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:CMSInitiatingOccupancyFraction=80 -XX:ReservedCodeCacheSize=128m -Duser.timezone=CET -Duser.language=nl -Duser.region=NL'
# JMX
export JAVA_OPTS="${JAVA_OPTS} -Dalfresco.home=${ALF_HOME} -Dcom.sun.management.jmxremote"
#
if [ "$1" = "start" ]; then
  "${APPSERVER}/bin/startup.sh"
elif [ "$1" = "stop" ]; then
  "${APPSERVER}/bin/shutdown.sh"
elif [ "$1" = "clean" ]; then
  read -p "Are you sure you want to delete temp, work and log data? (Yy/Nn) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Cleaning temp, work, log data...."
        rm -rf ${ALF_HOME}/alfresco.log*
        rm -rf ${ALF_HOME}/share.log*
        rm -rf ${ALF_HOME}/solr.log*
        rm -rf ${APPSERVER}/temp/*
        rm -rf ${APPSERVER}/work/*
        rm -rf ${APPSERVER}/logs/*
        echo "Succesfully cleaned temp, work, log data!"
  fi
elif [ "$1" = "cleanSolr" ]; then
  read -p "Are you sure you want to delete the Solr4 index? (Yy/Nn) " -n 1 -r
  echo "Cleaning Solr4 index...."
  if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf ${ALFDATA}/solr4/indexes/workspace/*
        rm -rf ${ALFDATA}/solr4/indexes/archive/*
        rm -rf ${ALFDATA}/solr4/model/*
        rm -rf ${ALFDATA}/solr4/content/*
        echo "Succesfully cleaned the Solr4 index!"
  fi
fi
