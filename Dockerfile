# branimir/alfresco-one

FROM centos:centos7
MAINTAINER Branimir Rajsic <branimir.rajsic@incentro.com>

# install some necessary/desired RPMs and get updates
RUN yum update -y
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y unzip supervisor
RUN yum clean all

# Create alfresco user
RUN groupadd -r alfresco && adduser -r -g alfresco alfresco

# install oracle java
COPY assets/jdk1.8.0_65.tar /tmp/jdk1.8.0_65.tar
COPY assets/install_scripts/install_java.sh /tmp/install_java.sh
RUN chmod +x /tmp/install_java.sh
RUN /tmp/install_java.sh && rm -f /tmp/install_java.sh

# install alfresco
COPY assets/alfresco-one-distribution-5.1.2.zip /tmp/alfresco-one-distribution-5.1.2.zip
COPY assets/install_scripts/install_alfresco.sh /tmp/install_alfresco.sh
RUN chmod +x /tmp/install_alfresco.sh
RUN /tmp/install_alfresco.sh && rm -f /tmp/install_alfresco.sh

# install alfresco
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
