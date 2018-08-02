# See main Vagrantfile for default settings and provisioners

config.vm.define "diff" do |diff|
  dev.vm.hostname = "diff.vagrant.localdomain"
  dev.vm.network "private_network", ip: "192.168.96.12", :netmask => "255.255.255.0"
end

config.vm.define "api" do |api|
  dev.vm.hostname = "api.vagrant.localdomain"
  dev.vm.network "private_network", ip: "192.168.96.13", :netmask => "255.255.255.0"
end

config.vm.define "ui" do |ui|
  dev.vm.hostname = "ui.vagrant.localdomain"
  dev.vm.network "private_network", ip: "192.168.96.14", :netmask => "255.255.255.0"
end
