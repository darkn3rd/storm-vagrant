# -*- mode: ruby -*-
# vi: set ft=ruby :

############### CONSTANTS
TIME = Time.now.strftime("%Y%m%d%H%M%S")
ENVIRONMENT = ENV['VAGRANT_ENV'] || 'default'
CONFIGFILE_HOSTS = "./config/#{ENVIRONMENT}.hosts"
PRIMARY_SYSTEM = if ENVIRONMENT =~ /dev/ then "maven" else "nimbus" end

############### BUILD RUBY DATA STRUCTURE (Hash)
hosts = {}  # empty data-structure
File.readlines(CONFIGFILE_HOSTS).map(&:chomp).each do |line|
  ipaddr, hostname = line.split(/\s+/)
  hosts[hostname] = ipaddr
end

Vagrant.configure("2") do |config|
  hosts.each do |hostname, ipaddr|
    default = if hostname == PRIMARY_SYSTEM then true else false end
    config.vm.define hostname, primary: default do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "#{hostname}"
      node.vm.network "private_network", ip: ipaddr
      node.vm.provider("virtualbox") { |vbox| vbox.name = "#{hostname}_#{TIME}" }

      # Provision
      node.vm.provision "shell", path: "scripts/setup-all.sh"
      node.vm.provision "shell", path: "scripts/#{hostname.split(/\./)[0]}.sh"
    end
  end
end
