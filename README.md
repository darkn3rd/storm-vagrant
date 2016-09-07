# **Vagrant-Shell Storm Cluster**

    by Joaquin Menchaca on May 2nd, 2016
    Updated September 1st, 2016

This creates a Apache Storm Cluster using Vagrant with shell provisioning.

## **About**

I set out to build a more recent Apache Storm Cluster (version 0.10.0) using [official docs](http://storm.apache.org/releases/0.10.0/Setting-up-a-Storm-cluster.html) and  insights from a collage of older How-Tos, [Dockerfiles](https://hub.docker.com/search/?q=storm), and provisioning scripts ([pallet](http://palletops.com), [puppet](https://puppet.com), [chef](https://www.chef.io), [ansible](https://www.chef.io), etc.).  From all of this research, I put together these some provisioning scripts that will build a small cluster (zookeeper, nimbus, 2 supervisor slaves) running on Ubuntu Trusty Tahr.

The following packages are installed:
 * Oracle JDK 1.8 (webupd8team PPA)
 * Zookeeper 3.4.5 (apt-get)
 * Apache Storm 0.10.0 (downloaded tarball)
 * Supvervisor (apt-get)

## **Instructions**

With [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed, just run:

```ShellSession
$ vagrant up
```

This brings up four systems on `192.168.54.0/24` (see `config/global.hosts`). You then can point a web browser to http://192.168.54.4:8080 to view the GUI.

### **Running a Topology**

To run a topology, log into nimbus system (default) and submit a topology to the cluster from the topologies directory:

```ShellSession
$ vagrant ssh
vagrant@nimbus:~$ storm jar \
  /vagrant/topologies/storm-starter-0.10.0.jar \
  storm.starter.RollingTopWords \
  my_topology_name remote
```

### **Building Topologies**

You need to bring up a build environment.  There are two supported:
  *  `dev_local` for a single-node build environment, and
  * `dev_remote` for build environment with a full cluster.

First bring up the environment(s):

```ShellSession
$ export VAGRANT_ENV=dev_remote
$ vagrant up
$ vagrant ssh
```

This brings up the maven build system, then you can compile topologies, such as the storm starter.

```ShellSession
$ cd /usr/lib/apache/storm/0.10.0/examples/storm-starter
$ sudo mvn clean install -DskipTests=true
$ cp target/storm-starter-0.10.0.jar /vagrant/topologies/
```

### **Using A Proxy Server**

You can view the cluster from your host using the web interface, `storm ui` and `storm logviewer`.  Optional you can use a proxy server to route to appropriate backend servers:

* [Proxy Instructions](PROXY.MD)

### **Prerequisites**

Both [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) must be installed.  You can download them manually, or use the tools listed below for Mac OS X or Windows.

#### **Mac OS X**

You can get the prerequisites using [Homebrew](http://brew.sh/), and [Brew Bundle](https://github.com/Homebrew/homebrew-bundle):

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
## Install Virtualbox and Vagrant
brew bundle
```

#### **Windows**

You can get the prerequisites using [Chocolately](https://chocolatey.org/) on Windows.  

```batch
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
:: Install Virtualbox and Vagrant
choco install chocolately.config
```

This also installs a bash shell and ssh client using [MSYS2](https://msys2.github.io/).

## **Research**

This is material I came across while researching Apache Storm Cluster (version 0.10.0):

* Official Documentation
  * [Setting up a Storm Cluster (Version 0.10.0)](http://storm.apache.org/releases/0.10.0/Setting-up-a-Storm-cluster.html)
  * [Storm downloads](http://storm.apache.org/downloads.html)
  * [Storm 0.10.0 Release Notes](https://github.com/apache/storm/blob/v0.10.0/CHANGELOG.md)
* Overview:
  * [Understanding the Parallelism of a Storm Topology](http://www.michael-noll.com/blog/2012/10/16/understanding-the-parallelism-of-a-storm-topology/)
* Starter Topologies
  * [Example Storm Topologies](https://github.com/apache/storm/tree/v0.10.0/examples/storm-starter)
* How-Tos:
  * [Running a Multi-Node Storm Cluster](http://www.michael-noll.com/tutorials/running-multi-node-storm-cluster/) - JDK 1.6, ZooKeeper 3.4.5, ZreoMQ 2.1.7, JZMQ 2.1, and Apache Storm 0.8.2, using supervisord to manage services.
  * [How to Install a Distributed Apache Storm Cluster](http://knowm.org/how-to-install-a-distributed-apache-storm-cluster/) - documents JDK 1.8, and Apache Storm 0.9.5, using upstart to manage services.
  * [Creating a Production Storm Cluster](http://tutorials.github.io/pages/creating-a-production-storm-cluster.html?ts=1340499018#.VyeUqz87Snc) - documents JDK 1.7, Zookeeper 3.4.3, ZeroMQ 2.1.7, JZMQ, and Apache Storm 0.7.0 and manually running services with `nohup`.
  * [Apache Storm - Installation (Tutorials Point)](http://www.tutorialspoint.com/apache_storm/apache_storm_installation.htm) - documents single  system with JDK 1.8, Zookeeper 3.4.6, Apache Storm 0.9.5
* Automation (Vagrant, Pallet)
  * [Storm-Deploy (uses Pallet)](https://github.com/nathanmarz/storm-deploy) - designated as *ancient* on user mailing list, targets Apache Storm 0.9.0 on AWS.
  * [PT Goetz's Vagrant](https://github.com/ptgoetz/storm-vagrant) - documents Storm 0.9.0.1

## **License**

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
