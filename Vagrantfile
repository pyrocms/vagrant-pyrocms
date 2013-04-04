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
  config.vm.share_folder "v-web", "/vagrant/www/", "./www", :owner => "www-data", :group => "www-data", :extra => "dmode=775,fmode=644"
  config.vm.share_folder "v-db", "/vagrant/db/", "./db", :owner => "www-data", :group => "www-data", :extra => "dmode=775,fmode=644"

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
    config.vm.network :hostonly, "198.18.0.201"

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
    end
  end

  ###
  #  Creates a basic LAMP stack with MySQL and Professional
  #  
  #  To launch run: vagrant up pro_mysql
  ###
  config.vm.define :pro_mysql do |mysqlp_config|
    # Map dev.pyrocms-pro.mysql to this IP
    mysqlp_config.vm.network :hostonly, "198.18.0.211"

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
    end
  end

  ###
  #  Creates an instance with SQLite as the database
  #  
  #  To launch run: vagrant up sqlite
  ###
  config.vm.define :sqlite do |sqlite_config|
    # Map dev.pyrocms.sqlite to this IP
    sqlite_config.vm.network :hostonly, "198.18.0.202"

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
    end
  end

  ###
  #  Creates an instance with SQLite as the database and Professional
  #  
  #  To launch run: vagrant up pro_sqlite
  ###
  config.vm.define :pro_sqlite do |sqlite_config|
    # Map dev.pyrocms.sqlite to this IP
    sqlite_config.vm.network :hostonly, "198.18.0.212"

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
    end
  end

  ###
  #  Creates an instance using PostgreSQL as the database
  #  
  #  To launch run: vagrant up pgsql
  ###
  config.vm.define :pgsql do |pgsql_config|
    # Map dev.pyrocms.postgres to this IP
    pgsql_config.vm.network :hostonly, "198.18.0.203"

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
    end
  end

  ###
  #  Creates an instance using PostgreSQL as the database
  #  
  #  To launch run: vagrant up pro_pgsql
  ###
  config.vm.define :pro_pgsql do |pgsql_config|
    # Map dev.pyrocms.postgres to this IP
    pgsql_config.vm.network :hostonly, "198.18.0.213"

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
    end
  end

end