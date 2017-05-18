# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = "ansible-roles"
name = "Ansible Roles"

cpus = 1
memory = 512

Vagrant.configure(2) do |config|
    # Ubuntu 14.04 Trusty
    config.vm.define :trusty do |trusty|
        trusty.vm.box = "ubuntu/trusty64"
        trusty.vm.hostname = "#{hostname}-trusty.chialab.local"

        # VirtualBox provider settings:
        trusty.vm.provider "virtualbox" do |vb|
            vb.name = "#{name} (14.04 Trusty)"
            vb.customize [
                "modifyvm", :id,
                "--groups", "/Vagrant"
            ]

            vb.cpus = cpus
            vb.memory = memory
        end
    end

    # Ubuntu 16.04 Xenial
    config.vm.define :xenial do |xenial|
        xenial.vm.box = "ubuntu/xenial64"
        xenial.vm.hostname = "#{hostname}-xenial.chialab.local"

        # VirtualBox provider settings:
        xenial.vm.provider "virtualbox" do |vb|
            vb.name = "#{name} (16.04 Xenial)"
            vb.customize [
                "modifyvm", :id,
                "--groups", "/Vagrant"
            ]

            vb.cpus = cpus
            vb.memory = memory
        end
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
