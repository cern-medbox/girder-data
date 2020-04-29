#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

#added user for the service
useradd girder
cd /home/girder/

#install base packages
sudo yum -y install epel-release
sudo yum -y install python3-pip python3-virtualenv gcc python3-devel curl

cp mongodb-org-4.2.repo /etc/yum.repos.d/

sudo yum -y install mongodb-org-server mongodb-org-shell
sudo systemctl start mongod

curl -fsL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum -y install nodejs

#install girder from our repository
git clone https://github.com/cern-medbox/girder.git
cd girder && python3 setup.py install && cd ..

#installing plugins
cd girder/plugins
#uncomment/comment required plugins
# read more on https://github.com/girder/girder/blob/master/docs/plugins.rst
#cd audit_logs && python3 setup.py install&& cd ..
cd authorized_upload && python3 setup.py install&& cd ..
cd autojoin && python3 setup.py install&& cd ..
cd dicom_viewer && python3 setup.py install&& cd ..
cd download_statistics && python3 setup.py install&& cd ..
cd google_analytics && python3 setup.py install&& cd ..
cd gravatar && python3 setup.py install&& cd ..
cd hashsum_download && python3 setup.py install&& cd ..
cd homepage && python3 setup.py install&& cd ..
cd item_licenses && python3 setup.py install&& cd ..
#cd jobs && python3 setup.py install&& cd ..
#cd ldap && python3 setup.py install&& cd ..
#cd oauth && python3 setup.py install&& cd ..
#cd sentry && python3 setup.py install&& cd ..
cd terms && python3 setup.py install&& cd ..
cd thumbnails && python3 setup.py install&& cd ..
cd user_quota && python3 setup.py install&& cd ..
#cd virtual_folders && python3 setup.py install&& cd ..

#Firewall enabling
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload

