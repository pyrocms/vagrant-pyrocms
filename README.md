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

	$ mkdir ~/vagrant
	$ git clone --recursive git://github.com/pyrocms/vagrant-pyrocms.git ~/vagrant/pyrocms
	$ cd ~/vagrant/pyrocms
	$ vagrant up mysql

There are 6 available boxes:

	* mysql
	* sqlite
	* postgres
	* pro_mysql
	* pro_sqlite
	* pro_postgres

_**Note**: The boxes prefixed with "pro" are Profesional only, which will be explained below.

Each box has it's own local IP and its own virtual host set up, so you can set the following in your `/etc/hosts` file:

# PyroCMS Community

	198.18.0.201 dev.pyrocms.mysql
	198.18.0.202 dev.pyrocms.sqlite
	198.18.0.203 dev.pyrocms.postgres

# PyroCMS Professional (optional)

	198.18.0.211 dev.pyrocms-pro.mysql
	198.18.0.212 dev.pyrocms-pro.sqlite
	198.18.0.213 dev.pyrocms-pro.postgres

Then simply browse to `http://dev.pyrocms.mysql/`. If you would like to only bring up one server then run:

	vagrant halt # takes down all servers
	vagrant up mysql # bring up just the one

This will hopefully give you a chance to play around with different systems other than just MySQL for a change.

## Enable PyroCMS Professional

To use the PyroCMS Professional boxes you will need access to the Professional repo on GtHub. To do this 
simply email [support@pyrocms.com](mailto:support@pyrocms.com) with your GitHub and PyroCMS.com usernames. 

When you have access, add PyroCMS Professional as a submodule:

	$ cd ~/vagrant/pyrocms
	$ git submodule add git@github.com:pyrocms/pyrocms-professional.git ./www/pyrocms-pro

Alternatively you can paste your downloaded ZIP file contents into the `/vagrant/www/pyrocms-pro` folder.

## Configuring Vagrant

There is a `Vagrantfile` included in the root of this repository with some default settings enabled.

## Configuring Puppet

This repo includes a submodule which contains all of our [Puppet Manifests](https://github.com/pyrocms/puppet-pyrocms), with various modules for building general LAMP-ish stacks. We have a few PHP, Apache, Nginx, MySQL, Postgres and SQLite combinations and more will be made over time.
