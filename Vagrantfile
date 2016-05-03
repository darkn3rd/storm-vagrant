# -*- mode: ruby -*-
# vi: set ft=ruby :

time = Time.now.strftime("%Y%m%d%H%M%S")

############### CONSTANTS
CONFIGFILE_HOSTS="./config/global.hosts"

############### BUILD RUBY DATA STRUCTURE (Hash)
hosts = {}  # empty data-structure
File.readlines(CONFIGFILE_HOSTS).map(&:chomp).each do |line|
  ipaddr, hostname = line.split(/\s+/)
  hosts[hostname] = ipaddr
end

Vagrant.configure("2") do |config|
  hosts.each do |hostname, ipaddr|
    default = if hostname == "nimbus" then true else false end
    config.vm.define hostname, primary: default do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "#{hostname}"
      node.vm.network "private_network", ip: ipaddr
      node.vm.provider("virtualbox") { |vbox| vbox.name = "#{hostname}_#{time}" }

      # Provision
      node.vm.provision "shell", path: "scripts/setup-all.sh"
      node.vm.provision "shell", path: "scripts/#{hostname}.sh"
    end
  end
end
