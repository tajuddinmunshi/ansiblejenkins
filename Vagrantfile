# Box / OS
VAGRANT_BOX = 'centos/7'
# VM User — 'vagrant' by default
VM_USER = 'vagrant'
# Username on your Mac
MAC_USER = 'tajuddinmunshi'
# Host folder to sync
HOST_PATH = '/Users/' + MAC_USER + '/' + 'vagrant/project1/shared'
# Where to sync to on Guest — 'vagrant' is the default user name
GUEST_PATH = '/home/' + VM_USER + '/shared'
# # VM Port — uncomment this to use NAT instead of DHCP
#VM_PORT = 8080






Vagrant.configure(2) do |config|
 
  config.vm.define "Jenkins-slave1" do |js1|

    js1.vm.box = VAGRANT_BOX

    js1.vm.hostname = 'Jenkins-slave1'
    js1.vm.provider "virtualbox" do |v|
    v.name = 'Jenkins-slave1'
    v.memory = 2048
    v.cpus = 1
    end
    js1.vm.network "private_network", ip: '10.103.13.11'
    js1.vm.network "forwarded_port", guest: 22, host: 3200, id: 'ssh'
#    js1.vm.synced_folder HOST_PATH, GUEST_PATH
#    js1.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
    js1.vm.provision "ansible" do |ansible|
        ansible.playbook = "slaveplaybook.yml"
    end
    js1.vm.provision "shell", path: "slavescript.sh"
  end
 
  config.vm.define "Jenkins-master" do |jm|
 
    jm.vm.box = VAGRANT_BOX
    jm.vm.hostname = 'Jenkins-master'
    jm.vm.provider "virtualbox" do |v|
    v.name = 'Jenkins-master'
    v.memory = 2048
    v.cpus = 1
    end
    jm.vm.network "private_network", ip: '10.103.13.10'
    jm.vm.network "forwarded_port", guest: 22, host: 3300, id: 'ssh'
#    jm.vm.synced_folder HOST_PATH, GUEST_PATH
#    jm.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
    jm.vm.provision "ansible" do |ansible|
        ansible.playbook = "masterplaybook.yml"
    end
    jm.vm.provision "shell", path: "masterscript.sh"
  end
  config.vm.box_check_update = false
  if Vagrant.has_plugin?("vagrant-vbguest") then
       config.vbguest.auto_update = false
  end  
end
