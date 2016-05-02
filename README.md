# **Vagrant-Shell Storm Cluster**

by Joaquin Menchaca on May 2nd, 2016

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

```bash
vagrant up
```

This brings up four systems on `192.168.54.0/24` (see `config/global.hosts`). You then can point a web browser to http://192.168.54.4:8080 to view the GUI.

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

## **License**

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
