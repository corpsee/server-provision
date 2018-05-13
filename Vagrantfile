Vagrant.configure("2") do |config|
    # "ubuntu/xenial64" | "ubuntu/bionic64"
    config.vm.box      = "ubuntu/xenial64"
    config.vm.hostname = "corpsee.test"

    config.vm.network :private_network, ip: "192.168.56.10"
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
        vb.name = "default"
        vb.customize [
            "modifyvm", :id,
            "--name", "default",
            "--memory", "1024",
            "--natdnshostresolver1", "on",
            "--cpus", 1,
        ]
    end

    config.vm.provision "ansible" do |ansible|
        ansible.playbook           = "playbooks/web_server.yml"
        ansible.inventory_path     = "inventories/vagrant.ini"
        ansible.compatibility_mode = "2.0"
        ansible.limit              = 'all'
        ansible.verbose            = "v"
    end

    config.vm.synced_folder "./", "/vagrant"
end
