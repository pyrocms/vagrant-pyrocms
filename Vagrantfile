# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Operating System

  ## Ubuntu 10.04 LTS (32-bit)
  #config.vm.box = "lucid32"
  #config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  ## Ubuntu 10.04 LTS (64-bit)
  # config.vm.box = "lucid64"
  # config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
 
  ## Ubuntu 12.04 LTS (32-bit)
  # config.vm.box = "precise32"
  # config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  ## Ubuntu 12.04 LTS (64-bit)
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.10"

  # Set the default project share to use nfs
  config.vm.share_folder("v-web", "/vagrant/www", "./www", :nfs => true)
  config.vm.share_folder("v-db", "/vagrant/db", "./db", :nfs => true)

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8089

  # Set the Timezone to something useful
  config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  
  # Enable PHP 5.4 (comment this out to use Ubuntu's default: which is probably 5.3)
  # config.vm.provision :shell, :inline => "apt-get install -y python-software-properties && add-apt-repository ppa:ondrej/php5"

  # Update the server
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"

  # Enable Puppet
  config.vm.provision :puppet do |puppet|
    puppet.facter = { "fqdn" => "local.pyrocms", "hostname" => "www" } 
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "ubuntu-apache2-mysql-php5.pp"
    puppet.module_path  = "puppet/modules"
  end

end
