# See main Vagrantfile for default settings and provisioners

# OJS
config.vm.define "ojs" do |ojs|
  ojs.vm.hostname = "ojs.vagrant.localdomain"
  ojs.vm.network "private_network", ip: "192.168.96.11", :netmask => "255.255.255.0"
  ojs.vm.provider :virtualbox do |v|
    v.memory = 2000
    v.cpus = 2
  end
end

