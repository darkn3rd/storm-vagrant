# **Configure Proxy Server**

This sets up a front web [reverse-proxy](https://en.wikipedia.org/wiki/Reverse_proxy) web server to route traffic to back end servers.  Even though virtualbox allows direct access, you simulate restricted network using this system.

This has two parts, client side dns cache server using DNSMasq, and back-end proxy server using NGiNX.

## **1. Client-Side Requirements**

Use the `hosts` file or dns-cache like DNSMasq.  Designate `192.168.54.3` as the reverse-proxy web service.

### **Hosts File**

```
192.168.54.3 zookeeper.dev zookeeper2.dev nimbus.dev nimbus2.dev supervisor1.dev supervisor2.dev storm.dev
```

### **DNS cache Server: DNSMasq**

```
address=/nimbus.dev/192.168.54.3
address=/nimbus2.dev/192.168.54.3
address=/supervisor1.dev/192.168.54.3
address=/supervisor2.dev/192.168.54.3
address=/zookeeper.dev/192.168.54.3
address=/zookeeper2.dev/192.168.54.3
address=/storm.dev/192.168.54.3
```

## **2. Proxy Server**

Point the web browser to http://storm.dev once systems come up.

```bash
$ export STORM_ENV="ha_proxy"  # high-availability storm w/ proxy
$ vagrant up
```

## **3. Mac OS X Notes**

### **Install**

[Homebrew](brew.sh) must be installed for this.

```bash
brew up
brew install dnsmasq
```

### **Setup**

```bash
# Copy the default configuration file.
cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
# Copy the daemon configuration file into place.
sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
# Start Dnsmasq automatically.
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
```

### **Configure**

```bash
vi /usr/local/etc/dnsmasq.conf  # add entries as desired
sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq
```

### **Test**

```bash
dig storm.dev @127.0.0.1
ping -c 1 storm.dev
curl storm.dev
```

### **Troubleshooting**

If you are getting weird addresses back on Yosemite or later:

```bash
sudo killall -HUP mDNSResponder
```
