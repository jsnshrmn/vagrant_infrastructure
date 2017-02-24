# See main Vagrantfile for default settings and provisioners

# Nginx
config.vm.define "nginx" do |nginx|
  nginx.vm.hostname = "nginx.vagrant.localdomain"
  nginx.vm.network "private_network", ip: "192.168.96.3", :netmask => "255.255.255.0"
end

# Drupal 7
config.vm.define "d7" do |d7|
  d7.vm.hostname = "d7.vagrant.localdomain"
  d7.vm.network "private_network", ip: "192.168.96.4", :netmask => "255.255.255.0"
end

# # CAS
# config.vm.define "cas" do |cas|
#   cas.vm.hostname = "cas.vagrant.localdomain"
#   cas.vm.network "private_network", ip: "192.168.96.5", :netmask => "255.255.255.0"
#   cas.vm.provider :virtualbox do |v|
#     v.memory = 1024
#   end
# end

# Search Gateway
config.vm.define( "apigate") do |apigate|
  apigate.vm.hostname = "apigate.vagrant.localdomain"
  apigate.vm.network "private_network", ip: "192.168.96.6", :netmask => "255.255.255.0"
end

# Solr
config.vm.define( "solr") do |solr|
  solr.vm.hostname = "solr.vagrant.localdomain"
  solr.vm.network "private_network", ip: "192.168.96.7", :netmask => "255.255.255.0"
end
