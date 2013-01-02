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
	git clone --recursive git://github.com/pyrocms/devops-vagrant.git ~/vagrant/pyrocms
	cd ~/vagrant/pyrocms
	vagrant up

This will actually launch 3 boxes:

	* mysql
	* sqlite
	* postgres

Each box has it's own local IP and its own virtual host set up, so you can set the following in your `/etc/hosts` file:

	198.18.0.201 dev.pyrocms.mysql
	198.18.0.202 dev.pyrocms.sqlite
	198.18.0.203 dev.pyrocms.postgres

Then simply browse to `http://dev.pyrocms.mysql/`. If you would like to only bring up one server then run:

	vagrant halt # takes down all servers
	vagrant up mysql # bring up just the one

This will hopefully give you a chance to play around with different systems other than just MySQL for a change.

## Configuring Vagrant

There is a `Vagrantfile` included in the root of this repository with some default settings enabled. Change the port number or switch to 
using a hostonly connection. It's all in [here](https://github.com/pyrocms/vagrant/blob/master/Vagrantfile).

## Configuring Puppet

This repo includes a submodule which contains all of our [Puppet manifests](https://github.com/pyrocms/devops-puppet), and various 
modules for building a LAMP stack (or something) close to that at least. We have a few PHP, Apache, Nginx, MySQL, Postgres and SQLite combinations and more will be made over time.

## TODO

### CentOS / Redhat

Currently this repo uses a [fork](fork) of [saz/puppet-php](fork), which 
only supports Ubuntu and Debian, but could easily be extended to support more by adding to the [params.pp](params). If there are any CentOS guys out there, we would love your help making this work.

  [fork]: https://github.com/philsturgeon/puppet-php
  [saz]: https://github.com/saz/puppet-php
  [params]: https://github.com/philsturgeon/puppet-php/blob/master/manifests/params.pp

### More Manifiests

There plan is to add multiple "stock" Puppet manifest files in `manifests/` for various setups like:

* nginx + PHP + FPM + APC
* nginx + PHP + SQLite + Memcache

And of course everything in between. By building these boxes we can facilitate development and testing of PyroCMS in multiple environments 
far easier than if we have to wrestle these systems onto our personal workstations. If you would like to submit a manfest, please simply send in a pull request with a logical name, like `centos-nginx-php5-mysql.pp` and we'll merge it.
