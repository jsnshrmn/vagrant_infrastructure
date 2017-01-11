# See main Vagrantfile for default settings and provisioners

# Drupal 7
config.vm.define( "d7") do |d7|
  d7.vm.hostname = "d7.vagrant.localdomain"
end
