# **Vagrant-Shell Storm Cluster**

    by Joaquin Menchaca on May 2nd, 2016
    Updated September 10th, 2016

This creates a [Apache Storm](http://storm.apache.org/) Cluster using [Vagrant](https://www.vagrantup.com/) with shell provisioning.

## **About**

This builds a minimal Apache Storm cluster.  These scripts have been tested with `0.9.7`, `0.10.1`, and `1.0.2`.

The following packages are installed:
 * Oracle JDK 1.8 (webupd8team PPA)
 * Zookeeper 3.4.5 (apt-get)
 * Apache Storm (downloaded tarball)
 * Supvervisord service supervision (apt-get)

Optional packages:  
 * Maven build tools
 * NGiNX reverse-proxy (see [PROXY.MD](PROXY.MD))

## **Instructions**

With [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed, just run:

```bash
$ # Select an environment and version
$ export STORM_ENV="default"     # default
$ export STORM_VERSION="0.10.1" # defaults to 1.0.2
$ vagrant up
```

This brings up several systems on `192.168.54.0/24` (see `config/` directory). You then can point a web browser to http://192.168.54.10:8080.

### **Running a Topology**

After logging into any system with storm installed, e.g. nimbus or supervisor, run this:

```bash
$ # select appropriate storm starter and package path (varies)
$ STORM_VERSION='0.9.7'
$ STORM_MAJOR_VERSION=$(echo ${STORM_VERSION} | grep -o '^[0-9]*')
$ PACKAGE_PATH='storm.starter'
$ [ $STORM_MAJOR_VERSION -ge 1 ] && PACKAGE_PATH="org.apache.${PACKAGE_PATH}"
$ cd /usr/lib/apache/storm/${STORM_VERSION}/examples/storm-starter
$ storm jar \
    storm-starter-topologies-${STORM_VERSION}.jar \
    ${PACKAGE_PATH}.RollingTopWords \
    rolling_top_words_example remote
```

**Note**: The sample topologies after 1.x start with `org.apache.storm.starter`, while 0.x are `storm.starter`.

### **Building Topologies**

Bring up build environment
```bash
$ export STORM_ENV=dev_remote
$ export STORM_VERSION="1.0.2"
$ vagrant up         # if not currently brought up
$ vagrant ssh        # log into primary system
```

In the vagrant system:

```bash
$ STORM_VERSION='1.0.2'
$ cd /usr/lib/apache/storm/${STORM_VERSION}/examples/storm-starter
$ sudo mvn clean install -DskipTests=true
$ cp target/storm-starter-*.jar /vagrant/topologies/
```

### **Using A Proxy Server**

You can view the cluster from your host using the web interface, `storm ui` and `storm logviewer`.  Optional you can use a proxy server to route to appropriate backend servers:

 * [Proxy Instructions](PROXY.MD)

### **Prerequisites**

 *  [Vagrant](https://www.vagrantup.com/)
 *  [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

#### **Mac OS X**

The package manger [Homebrew](http://brew.sh/), and [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) can be used to installed the pre-requisites:

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

This also installs a `bash` shell and `ssh` client using [MSYS2](https://msys2.github.io/).

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
