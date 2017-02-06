# See main Vagrantfile for default settings and provisioners

# Drupal 7
config.vm.define( "d7") do |d7|
  d7.vm.hostname = "d7.vagrant.localdomain"
  d7.vm.network "private_network", ip: "192.168.96.4", :netmask => "255.255.255.0"
end
