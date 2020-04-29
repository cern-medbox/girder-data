#!/bin/bash

sudo yum -y install epel-release
sudo yum -y install python3-pip python3-virtualenv gcc python3-devel curl

cp mongodb-org-4.2.repo /etc/yum.repos.d/

sudo yum -y install mongodb-org-server mongodb-org-shell
sudo systemctl start mongod

curl -fsL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum -y install nodejs

git clone https://github.com/cern-medbox/girder.git
pip3 install -e ./girder

