# -*- mode: ruby -*-
# vi: set ft=ruby :

############### CONSTANTS
TIME = Time.now.strftime("%Y%m%d%H%M%S")
STORM_ENV = ENV['STORM_ENV'] || 'default'
STORM_VERSION = ENV['STORM_VERSION'] || "1.0.2" # 0.9.7, 0.10.1, 1.0.2
STORM_MAJOR_VERSION = STORM_VERSION.split(/\./)[0]
CONFIGFILE_HOSTS = "./config/#{STORM_MAJOR_VERSION}/#{STORM_ENV}.hosts"

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
          vbox.memory = 1024
          vbox.cpus = 2
        end
      else
        node.vm.provider("virtualbox") { |vbox| vbox.name = "#{hostname}_#{TIME}" }
      end

      # Provision Using Shell Script
      node.vm.provision "shell" do |script|
        script.env = { "STORM_ENV" => STORM_ENV }
        script.args = [STORM_VERSION]
        script.path = "scripts/#{hostname.split(/\./)[0]}.sh"
      end
    end
  end
end
