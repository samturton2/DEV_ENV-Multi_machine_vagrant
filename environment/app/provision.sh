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

# Install nginx
sudo apt-get install nginx -y

# set the db host to the same ip as the db in the global variable folder
echo "export DB_HOST=192.168.10.148" >> ~/.bashrc
# export DB_HOST=192.168.10.148
# export it to both .bashrc files just in case
echo "export DB_HOST=192.168.10.148" >> /home/ubuntu/.bashrc



# Move the synced reverse proxy configuration file to the sites available folder
sudo mv /home/ubuntu/app/reverse-proxy.conf /etc/nginx/sites-available/
# disable the default virtual host
sudo unlink etc/nginx/sites-enabled/default
# link the new proxy
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf

# finally, restart the nginx service so the new config takes hold
sudo service nginx restart
# go to app and install npm
cd /home/ubuntu/app
sudo npm install
pm2 start app.js --update-env
# Dont need to set the port as the mogodb is assigned to 0.0.0.0 so it listens across all ports