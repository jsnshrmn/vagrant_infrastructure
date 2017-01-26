# See main Vagrantfile for default settings and provisioners

# Solr
config.vm.define( "solr") do |solr|
  solr.vm.hostname = "solr.vagrant.localdomain"
end

# Drupal 7
config.vm.define( "d7") do |d7|
  d7.vm.hostname = "d7.vagrant.localdomain"
end

# Search Gateway
config.vm.define( "apigate") do |d7|
  d7.vm.hostname = "apigate.vagrant.localdomain"
end

# Nginx
config.vm.define( "nginx") do |nginx|
  nginx.vm.hostname = "nginx.vagrant.localdomain"
end
