# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "alpine/alpine64"

  config.vm.provider "virtualbox" do |vb|
    vb.name = 'alpine-docker-compose'
    vb.check_guest_additions = false
    vb.memory = "1024"
    vb.cpus = "2"
  end
  
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    # docker install is based on https://gist.github.com/paruljain/5a8ea11f58e3e4aea771a85ff4bdb0ce
    # See also https://wiki.alpinelinux.org/wiki/Docker
    echo http://dl-3.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
    echo http://dl-3.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
    apk update
    apk add docker
    rc-update add docker boot
    service docker start
    apk add curl
    chmod +x /vagrant/scripts/install-docker-compose.sh
    /vagrant/scripts/install-docker-compose.sh
    apk add bash-completion
    # 'shadow' is needed for 'usermod'
    apk add shadow
    usermod -a -G docker vagrant
  SHELL
end
