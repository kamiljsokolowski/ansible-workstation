# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
nodes = YAML.load_file('inventory.yml')

Vagrant.configure(2) do |config|

  nodes.each do |nodes|
      config.vm.define nodes["name"] do |node|
          node.vm.box = nodes["box"]
          node.vm.hostname = nodes["name"]
          node.vm.box_check_update = nodes["check_updates"]
          node.vm.network nodes["net"], ip: nodes["ip"]
          if nodes["forward_host_port"] and nodes["forward_guest_port"]
            node.vm.network "forwarded_port", guest: nodes["forward_host_port"], host: nodes["forward_guest_port"]
          end
          node.vm.provider "virtualbox" do |vb|
             vb.gui = nodes["gui"]
             vb.cpus = nodes["cpus"]
             vb.memory = nodes["mem"]
          end
          if nodes["privileged_scripts"]
            nodes["privileged_scripts"].each do |privileged_script|
              node.vm.provision "shell", path: privileged_script, privileged: true
            end
          end
          if nodes["scripts"]
            nodes["scripts"].each do |script|
              node.vm.provision "shell", path: script, privileged: false
            end
          end
          # Ansible
          if nodes["ansible_playbooks"]
            nodes["ansible_playbooks"].each do |ansible_playbook|
              node.vm.provision "ansible_local" do |ansible|
                ansible.limit = "all,localhost"            # fixes https://github.com/hashicorp/vagrant/issues/3140
                ansible.playbook = ansible_playbook
                ansible.install_mode = "pip"
                ansible.version = "2.5.0"
                # ansible.galaxy_roles_file = "ansible/requirements.yml"
                # ansible.galaxy_roles_path = "ansible/roles"
                # ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
              end
            end
          end
      end
  end
end
