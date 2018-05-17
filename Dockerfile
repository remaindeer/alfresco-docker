# branimir/alfresco-one

FROM centos:centos7
MAINTAINER Kagan Akbas <kagan.akbas@incentro.com>

# install some necessary/desired RPMs and get updates
RUN yum update -y
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y unzip supervisor
RUN yum clean all
RUN yum -y install rsync


# Create alfresco user
RUN groupadd -r alfresco && adduser -r -g alfresco alfresco

# install oracle java
COPY assets/jdk-8u111-linux-x64.tar.gz /tmp/jdk-8u111-linux-x64.tar.gz
COPY assets/install_scripts/install_java.sh /tmp/install_java.sh
RUN chmod +x /tmp/install_java.sh
RUN /tmp/install_java.sh && rm -f /tmp/install_java.sh

# install tomcat
COPY assets/config_files/catalina.properties /tmp/config_files/catalina.properties
COPY assets/apache-tomcat-7.0.82.tar.gz /tmp/apache-tomcat-7.0.82.tar.gz
COPY assets/install_scripts/install_tomcat.sh /tmp/install_tomcat.sh
RUN chmod +x /tmp/install_tomcat.sh
RUN /tmp/install_tomcat.sh && rm -f /tmp/install_tomcat.sh

# install alfresco
COPY assets/alfresco-content-services-distribution-5.2.3.zip /tmp/alfresco-content-services-distribution-5.2.3.zip
COPY assets/install_scripts/install_alfresco.sh /tmp/install_alfresco.sh
RUN chmod +x /tmp/install_alfresco.sh
RUN /tmp/install_alfresco.sh && rm -f /tmp/install_alfresco.sh

# install ImageMagick
COPY assets/ImageMagick-6.9.7-9.x86_64.rpm /tmp/ImageMagick-6.9.7-9.x86_64.rpm
COPY assets/ImageMagick-libs-6.9.7-9.x86_64.rpm /tmp/ImageMagick-libs-6.9.7-9.x86_64.rpm
COPY assets/install_scripts/install_thirdparty.sh /tmp/install_thirdparty.sh
RUN chmod +x /tmp/install_thirdparty.sh
RUN /tmp/install_thirdparty.sh && rm -f /tmp/install_alfresco.sh

# set Alfresco config
COPY assets/alfresco.sh /alfresco/alfresco.sh
COPY assets/alfresco-global.properties /alfresco/tomcat/shared/classes/alfresco-global.properties

# Initilize Alfresco
COPY assets/init.sh /alfresco/init.sh

# set permissions
COPY assets/install_scripts/set_permissions.sh /alfresco/set_permissions.sh
RUN chmod +x /alfresco/set_permissions.sh
RUN /alfresco/set_permissions.sh && rm -f /alfresco/set_permissions.sh

# Supervisor (Multi process)
COPY assets/supervisord.conf /etc/supervisord.conf
EXPOSE 445 8009 8080
CMD /usr/bin/supervisord -c /etc/supervisord.conf -n
