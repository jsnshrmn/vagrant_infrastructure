# See main Vagrantfile for default settings and provisioners

# Dev
config.vm.define "monitor" do |monitor|
  monitor.vm.hostname = "monitor.vagrant.localdomain"
  monitor.vm.network "private_network", ip: "192.168.96.12", :netmask => "255.255.255.0"
end

config.vm.define "elasticsearch" do |elasticsearch|
  elasticsearch.vm.hostname = "elasticsearch.vagrant.localdomain"
  elasticsearch.vm.network "private_network", ip: "192.168.96.13", :netmask => "255.255.255.0"
 end

config.vm.define "syslog" do |syslog|
  syslog.vm.hostname = "syslog.vagrant.localdomain"
  syslog.vm.network "private_network", ip: "192.168.96.14", :netmask => "255.255.255.0"
 end


