# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Operating System
 
  ## Ubuntu 12.04 LTS (32-bit)
  # config.vm.box = "precise32"
  # config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  ## Ubuntu 12.04 LTS (64-bit)
  # config.vm.box = "precise64"
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  ## Ubuntu 12.10 LTS (64-bit)
  config.vm.box = "quantal64"
  config.vm.box_url = "https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Set the default project share to use nfs
  config.vm.share_folder("v-web", "/vagrant/www", "./www", :nfs => true)
  config.vm.share_folder("v-db", "/vagrant/db", "./db", :nfs => true)

  # Set the Timezone to something useful
  config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  
  # Enable PHP 5.4 (comment this out to use Ubuntu's default: which is probably 5.3)
  # config.vm.provision :shell, :inline => "apt-get install -y python-software-properties && add-apt-repository ppa:ondrej/php5"

  # Update the server
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"


  ###
  #  Creates a basic LAMP stack with MySQL
  #  
  #  To launch run: vagrant up OR vagrant up default
  ###
  config.vm.define :mysql do |default_config|

    # Map dev.pyrocms.mysql to this IP
    config.vm.network :hostonly, "198.18.0.201"

    # Enable Puppet
    default_config.vm.provision :puppet do |puppet|
      puppet.facter = { "fqdn" => "dev.pyrocms.mysql", "hostname" => "www" } 
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "ubuntu-apache2-mysql-php5.pp"
      puppet.module_path  = "puppet/modules"
    end

  end


  ###
  #  Creates an instance with SQLite as the database
  #  
  #  To launch run: vagrant up sqlite
  ###
  config.vm.define :sqlite do |sqlite_config|

    # Map dev.pyrocms.sqlite to this IP
    config.vm.network :hostonly, "198.18.0.202"

    # Enable Puppet
    sqlite_config.vm.provision :puppet do |puppet|
      puppet.facter = { "fqdn" => "dev.pyrocms.sqlite", "hostname" => "www" } 
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "ubuntu-apache2-sqlite-php5.pp"
      puppet.module_path  = "puppet/modules"
    end

  end


  ###
  #  Creates an instance using PostgreSQL as the database
  #  
  #  To launch run: vagrant up pgsql
  ###
  config.vm.define :pgsql do |pgsql_config|

    # Map dev.pyrocms.postgres to this IP
    config.vm.network :hostonly, "198.18.0.203"

    # Enable Puppet
    pgsql_config.vm.provision :puppet do |puppet|
      puppet.facter = { "fqdn" => "dev.pyrocms.postgres", "hostname" => "www" } 
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "ubuntu-apache2-pgsql-php5.pp"
      puppet.module_path  = "puppet/modules"
    end

  end

end