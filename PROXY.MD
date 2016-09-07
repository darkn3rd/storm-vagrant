# **Configure Proxy Server**

If you wanted to have one front-end web server that can route to hidden servers appropriately, some notes on setting this up locally.


## **Host-Side Requirements**

On the host you can either edit your hosts file, or install a DNS caching server to resolve local DNS names.

### **Hosts File**

On Linux system, this is in `/etc/hosts`.  Other systems may vary.  You add entries like this, all pointing to the proxy server:

```
192.168.54.21 zookeeper.dev
192.168.54.21 nimbus.dev
192.168.54.21 supervisor1.dev
192.168.54.21 supervisor2.dev
192.168.54.21 storm.dev
```

### **DNS cache Server: DNSMasq**

```conf
address=/nimbus.dev/192.168.54.21
address=/supervisor1/192.168.54.21
address=/supervisor2/192.168.54.21
address=/zookeeper.dev/192.168.54.21
address=/storm.dev/192.168.54.21
```

## **DNSMasq on Mac OS X**

### **Install**

```bash
# Update your homebrew installation
brew up
# Install dnsmasq
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
curl storm.dev:8080
```

### **Troubleshooting**

If you are getting weird addresses back on Yosemite or later:

```bash
sudo killall -HUP mDNSResponder
```
