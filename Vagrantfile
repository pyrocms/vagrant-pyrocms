# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::configure("2") do |config|

  # Operating System
 
  ## Ubuntu 12.10 (64-bit)
  config.vm.box = "pyro-quantal64"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/37978558/quantal64.box"

  # Set the default project share to use nfs
  config.vm.synced_folder "./www", "/vagrant/www/", :nfs => true
  config.vm.synced_folder "./db", "/vagrant/db/", :nfs => true

  # Set the Timezone to something useful
  config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  # Update the server
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"

  ###
  #  Creates a basic LAMP stack with MySQL
  #  
  #  To launch run: vagrant up mysql
  ###
  config.vm.define :mysql do |mysql_config|
    # Map dev.pyrocms.mysql to this IP
    config.vm.network :private_network, ip: "198.18.0.201"

    # Enable Puppet
    mysql_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms.mysql", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms/'
      }
      puppet.manifest_file  = "ubuntu-apache2-mysql-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

  ###
  #  Creates a basic LAMP stack with MySQL and Professional
  #  
  #  To launch run: vagrant up pro_mysql
  ###
  config.vm.define :pro_mysql do |mysqlp_config|
    # Map dev.pyrocms-pro.mysql to this IP
    mysqlp_config.vm.network :private_network, ip: "198.18.0.211"

    # Enable Puppet
    mysqlp_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms-pro.mysql", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms-pro/'
      } 
      puppet.manifest_file  = "ubuntu-apache2-mysql-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

  ###
  #  Creates an instance with SQLite as the database
  #  
  #  To launch run: vagrant up sqlite
  ###
  config.vm.define :sqlite do |sqlite_config|
    # Map dev.pyrocms.sqlite to this IP
    sqlite_config.vm.network :private_network, ip: "198.18.0.202"

    # Enable Puppet
    sqlite_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms-pro.sqlite", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms/'
      } 
      puppet.manifest_file  = "ubuntu-apache2-sqlite-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

  ###
  #  Creates an instance with SQLite as the database and Professional
  #  
  #  To launch run: vagrant up pro_sqlite
  ###
  config.vm.define :pro_sqlite do |sqlite_config|
    # Map dev.pyrocms.sqlite to this IP
    sqlite_config.vm.network :private_network, ip: "198.18.0.212"

    # Enable Puppet
    sqlite_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms-pro.sqlite", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms-pro/'
      } 
      puppet.manifest_file  = "ubuntu-apache2-sqlite-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

  ###
  #  Creates an instance using PostgreSQL as the database
  #  
  #  To launch run: vagrant up pgsql
  ###
  config.vm.define :pgsql do |pgsql_config|
    # Map dev.pyrocms.postgres to this IP
    pgsql_config.vm.network :private_network, ip: "198.18.0.203"

    # Enable Puppet
    pgsql_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms-pro.postgres", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms/'
      }
      puppet.manifest_file  = "ubuntu-apache2-pgsql-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

  ###
  #  Creates an instance using PostgreSQL as the database
  #  
  #  To launch run: vagrant up pro_pgsql
  ###
  config.vm.define :pro_pgsql do |pgsql_config|
    # Map dev.pyrocms.postgres to this IP
    pgsql_config.vm.network :private_network, ip: "198.18.0.213"

    # Enable Puppet
    pgsql_config.vm.provision :puppet do |puppet|
      puppet.facter = { 
        "fqdn" => "dev.pyrocms-pro.postgres", 
        "hostname" => "www", 
        "docroot" => '/vagrant/www/pyrocms-pro/'
      } 
      puppet.manifest_file  = "ubuntu-apache2-pgsql-php5.pp"
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path  = "puppet/modules"
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
    end
  end

end
