# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = "ansible-roles"
name = "Ansible Roles"

cpus = 1
memory = 512

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "#{hostname}.chialab.local"

    # VirtualBox provider settings:
    config.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.customize [
            "modifyvm", :id,
            "--groups", "/Vagrant"
        ]

        vb.cpus = cpus
        vb.memory = memory
    end

    # Install Ansible via PIP and Git via APT:
    config.vm.provision "shell", path: "tests/install_ansible.sh"

    # Workaround for mitchellh/vagrant#6793 (see https://github.com/mitchellh/vagrant/issues/6793#issuecomment-172408346):
    config.vm.provision "shell" do |s|
        s.inline = '[[ ! -f $1 ]] || grep -F -q "$2" $1 || sed -i "/__main__/a \\    $2" $1'
        s.args = ['/usr/local/bin/ansible-galaxy', "if sys.argv == ['/usr/local/bin/ansible-galaxy', '--help']: sys.argv.insert(1, 'info')"]
    end

    # Ansible provisioning:
    config.vm.provision :ansible_local do |ansible|
        ansible.galaxy_roles_path = "."
        ansible.playbook = "tests/test.yml"
    end
end
