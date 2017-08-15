# See main Vagrantfile for default settings and provisioners

# Dspace
config.vm.define "dspace" do |dspace|
  dspace.vm.hostname = "dspace.vagrant.localdomain"
  dspace.vm.network "private_network", ip: "192.168.96.10", :netmask => "255.255.255.0"
end
