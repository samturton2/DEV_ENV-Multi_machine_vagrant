#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

sudo apt-get install nginx -y

# finally, restart the nginx service so the new config takes hold
sudo service nginx restart

# set the db host to the same ip as the db in the global variable folder
echo "export DB_HOST=192.168.10.148" >> ~/.bashrc
export DB_HOST=192.168.10.148
# go to app and install npm
cd /home/ubuntu/app
sudo npm install

pm2 start app.js
# Dont need to set the port as the mogodb is assigned to 0.0.0.0 so it listens across all ports