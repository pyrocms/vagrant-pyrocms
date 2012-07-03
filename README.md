# PyroCMS Vagrant

Configuration for [vagrant](http://vagrantup.com/) and puppet systems, allowing you to build a PyroCMS-friendly environment in next to no-time. 
That means that instead of needing to install XAMPP/WAMPP/MAMP, fight with the built in version of Apache on your Mac or configure some slow 
over-the-network VPS to run your code you can use our Vagrant / Puppy setup to run PyroCMS in its own little virtual box.

## Tools

### Vagrant

Create and configure lightweight, reproducible, and portable development environments. A command line wrapper for VirtualBox.

### Puppet

Puppet manages your servers: describe machine configurations in an easy-to-read declarative language, and Puppet will bring your systems into the desired state and keep them there.

## Installation

Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html) (which requires [VirtualBox](https://www.virtualbox.org/wiki/Downloads)) then run the following commands:

	mkdir ~/vagrant
	git clone --recursive git://github.com/pyrocms/vagrant.git ~/vagrant/pyrocms
	cd ~/vagrant/pyrocms
	vagrant up

That is all you need to get a virtual machine with everything you need set up to run PyroCMS. Check it is working by browsing 
to `http://localhost:8089/`. You can configure it to work on any port, we just put it there as 8080 is often taken too.

## Configurating Vagrant

There is a `Vagrantfile` included in the root of this repository with some default settings enabled. Change the port number or switch to 
using a hostonly connection. It's all in [here](https://github.com/pyrocms/vagrant/blob/master/Vagrantfile).

## Current Manfiests

imaginitively named `default.pp` which will eventially be the base for mulitple manaifests that do all 
sorts of weird and wonderful things with PHP 5.4, SQLite, Postgres, Redis, etc, but for now there is just the one basic lamp stack.

### default.pp

* Ubuntu Precise Pangolin 12.04 LTS (32-bit)
* PHP 5.3.2
	* xdebug
	* curl
	* gd
* MySQL Server
* MySQL Client
* PEAR
* PHPUnit
* Vim

MySQL Details

__User:__ pyrocms
__Pass:__ password
__Database:__ pyrocms

## TODO

### CentOS / Redhat

Currently this repo uses a [fork](fork) of [saz/puppet-php](fork), which 
only supports Ubuntu and Debian, but could easily be extended to support more by adding to the [params.pp](params). If there are any CentOS guys out there, we would love your help making this work.

  [fork]: https://github.com/philsturgeon/puppet-php
  [saz]: https://github.com/saz/puppet-php
  [params]: https://github.com/philsturgeon/puppet-php/blob/master/manifests/params.pp

### More Manifiests

There plan is to add multiple "stock" Puppet manifest files in `manifests/` for various setups like:
	
* Apache + PHP 5.4 + MySQL
* nginx + PHP 5.2 + Postgres
* nginx + PHP 5.3 + SQLite

And of course everything in between. By building these boxes we can facilitate development and testing of PyroCMS in multiple environments 
far easier than if we have to wrestle these systems onto our personal workstations. If you would like to submit a manfest, please simply send in 
a pull request with a logical name, like `nginx-php53-mysql.pp` and we'll merge it.