#!/bin/bash

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo "10.103.13.11 Jenkins-slave1" >> /etc/hosts 
sshpass -p vagrant scp -rp -o StrictHostKeyChecking=no vagrant@10.103.13.11:/tmp/id_rsa.pub /tmp/
sudo mkdir /var/lib/jenkins/.ssh
sudo cat /tmp/id_rsa.pub > /var/lib/jenkins/.ssh/known_hosts

sudo ssh-keyscan -H Jenkins-slave1 >>/var/lib/jenkins/.ssh/known_hosts
sudo ssh-keyscan -H 10.103.13.11 >>/var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh 
sudo chmod 700 /var/lib/jenkins/.ssh
sudo chmod 600 /var/lib/jenkins/.ssh/known_hosts
echo “use the below for admin login”
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

ip=`hostname -I | cut -d' ' -f2`
echo "Jenkins master successfully configured, the IP is: $ip"
host=`hostname`
echo "To login to machine use command: vagrant ssh $host"
