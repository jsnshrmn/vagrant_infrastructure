# Contributing

## Adding a New Project

* Copy the generic project as a basis for your project
* Add entries for the project's VMs to `hosts`, `ssh.cfg`, and the `${PROJECT}/vagrant.rb` file in your project
* Write a playbook to build your project at `${PROJECT}/playbooks/vagrant.yml` 
* Add the appropriate host variables at `${PROJECT}/host/host_vars`
