# See main Vagrantfile for default settings and provisioners

config.vm.define "diff" do |diff|
  diff.vm.hostname = "diff.vagrant.localdomain"
  diff.vm.network "private_network", ip: "192.168.96.12", :netmask => "255.255.255.0"
end

config.vm.define "api" do |api|
  api.vm.hostname = "api.vagrant.localdomain"
  api.vm.network "private_network", ip: "192.168.96.13", :netmask => "255.255.255.0"
end

config.vm.define "ui" do |ui|
  ui.vm.hostname = "ui.vagrant.localdomain"
  ui.vm.network "private_network", ip: "192.168.96.14", :netmask => "255.255.255.0"
end
