# -*- mode: ruby -*-
# vi: set ft=ruby :

############### CONSTANTS
TIME = Time.now.strftime("%Y%m%d%H%M%S")
ENVIRONMENT = ENV['VAGRANT_ENV'] || 'default'
CONFIGFILE_HOSTS = "./config/#{ENVIRONMENT}.hosts"

############### BUILD RUBY DATA STRUCTURE (Hash)
hosts = {}  # empty data-structure
File.readlines(CONFIGFILE_HOSTS).map(&:chomp).each do |line|
  ipaddr, hostname = line.split(/\s+/)             # only grab first two columns
  hosts[hostname] = ipaddr                         # store in hash
  PRIMARY_SYSTEM = hostname if (line =~ /primary/) # match primary
end

Vagrant.configure("2") do |config|
  hosts.each do |hostname, ipaddr|
    default = if hostname == PRIMARY_SYSTEM then true else false end
    config.vm.define hostname, primary: default do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "#{hostname}"
      node.vm.network "private_network", ip: ipaddr

      case hostname
      when /nimbus/
        node.vm.provider "virtualbox" do |vbox|
          vbox.name = "#{hostname}_#{TIME}"
          vbox.memory = 1536 # npm 1.1gb + node_gyp 700mb + cc1plus 87mb
          vbox.cpus = 2
        end
      else
        node.vm.provider("virtualbox") { |vbox| vbox.name = "#{hostname}_#{TIME}" }
      end

      # Provision
      node.vm.provision "shell", path: "scripts/#{hostname.split(/\./)[0]}.sh"
    end
  end
end
