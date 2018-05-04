#!/usr/bin/env bash
set -e

# Install dependencies
yum install -y ghostscript libXrender libSM libICE libXext libXinerama fontconfig cups-libs mesa-libGL mesa-libGLU lcms2 fftw3 libXt libtool-ltdl.x86_64

# Install libreoffice
curl -o /tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm.tar.gz https://downloadarchive.documentfoundation.org/libreoffice/old/4.4.5.2/rpm/x86_64/LibreOffice_4.4.5.2_Linux_x86-64_rpm.tar.gz
tar -xvf /tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm.tar.gz -C /tmp/
chown -R alfresco.alfresco /tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm
chown -R alfresco.alfresco /alfresco
runuser -l  alfresco -c 'mkdir /alfresco/libreoffice'
runuser -l  alfresco -c '/tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm/install /tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm/RPMS /alfresco/libreoffice'
mv /alfresco/libreoffice/opt/libreoffice4.4/* /alfresco/libreoffice

# Install ImageMagick
rpm -Uvh --nodeps /tmp/ImageMagick-libs-6.9.7-9.x86_64.rpm
rpm -Uvh --nodeps /tmp/ImageMagick-6.9.7-9.x86_64.rpm

# Remove tmp files
rm -rf /tmp/ImageMagick-*
rm -rf /tmp/LibreOffice_4.4.5.2_Linux_x86-64_rpm*