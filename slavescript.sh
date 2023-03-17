#!/bin/bash

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo useradd jenkinsnew
sudo mkdir /home/jenkinsnew/.ssh
sudo chmod 700  /home/jenkinsnew/.ssh
sudo chown -R jenkinsnew:jenkinsnew /home/jenkinsnew/.ssh
su - jenkinsnew -c "ssh-keygen -t rsa -N '' -f /home/jenkinsnew/.ssh/id_rsa"
sudo cat /home/jenkinsnew/.ssh/id_rsa.pub > /home/jenkinsnew/.ssh/authorized_keys   
sudo chmod 700 /home/jenkinsnew/.ssh/authorized_keys
sudo chown -R jenkinsnew:jenkinsnew /home/jenkinsnew/.ssh
sudo cp /home/jenkinsnew/.ssh/id_rsa.pub /tmp/
sudo chown vagrant:vagrant /tmp/id_rsa.pub 
echo “use below private key to setup this slave node in jenkins”
sudo cat /home/jenkinsnew/.ssh/id_rsa


ip=`hostname -I | cut -d' ' -f2`
echo "Jenkins master successfully configured, the IP is: $ip"
host=`hostname`
echo "To login to machine use command: vagrant ssh $host"
