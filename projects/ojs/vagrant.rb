# See main Vagrantfile for default settings and provisioners

# OJS
config.vm.define "ojs" do |ojs|
  ojs.vm.hostname = "ojs.vagrant.local"
end

# Nginx
config.vm.define "nginx" do |nginx|
  nginx.vm.hostname = "nginx.vagrant.local"
  nginx.vm.network "forwarded_port", guest:443, host:64443
end
