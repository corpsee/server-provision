Vagrant.configure("2") do |config|

    config.vm.box      = "ubuntu/xenial64"
    config.vm.hostname = "corpsee.virtual"

    config.vm.network :private_network, ip: "192.168.56.20"
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
        ansible.playbook       = "playbooks/web-server-install.yml"
        ansible.inventory_path = "inventories/vagrant.ini"
        ansible.limit          = 'all'
        #ansible.ask_vault_pass = true
        ansible.verbose        = "v"
    end

    config.vm.synced_folder "./", "/vagrant"
end
