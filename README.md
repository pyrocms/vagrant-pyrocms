# PyroCMS Vagrant

Configuration for [vagrant](http://vagrantup.com/) and puppet systems, allowing you to build a PyroCMS-friendly environment in next to no-time.

## What?

### Vagrant

Create and configure lightweight, reproducible, and portable development environments.

### Puppet

Puppet manages your servers: describe machine configurations in an easy-to-read declarative language, and Puppet will bring your systems into the desired state and keep them there.

## How?

Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html) (which requires [VirtualBox](https://www.virtualbox.org/wiki/Downloads)) then run the following commands:

	git clone --recursive git://github.com/pyrocms/vagrant.git pyrocms-vagrant
	cd pyrocms-vagrant/
	vagrant up

That is all you need to get a virtual machine with everything you need set up to run PyroCMS.

## What is included?

There is a Puppet manifest imaginitively named `default.pp` which will eventially be the base for mulitple manaifests that do all 
sorts of weird and wonderful things with PHP 5.4, SQLite, Postgres, Redis, etc, but for now there is just the one basic lamp stack.

### default.pp

* Ubuntu Lucid Lynx (32-bit)
* PHP 5.3.2
	* xdebug
	* curl
	* gd
* MySQL Server
* MySQL Client
* PEAR
* PHPUnit
* Vim