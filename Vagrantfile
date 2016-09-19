Vagrant.configure("2") do |config|

    config.vm.box      = "ubuntu/trusty64"
    config.vm.hostname = "corpsee-com-server"

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
        ansible.playbook       = "ansible/web-server-playbook.yml"
        ansible.inventory_path = "ansible/inventories/vagrant-inventory"
        ansible.limit          = 'all'
        ansible.ask_vault_pass = true
        ansible.verbose        = "vvv"
    end

    config.vm.synced_folder "./", "/vagrant"
end
