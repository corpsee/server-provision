Vagrant.configure("2") do |config|

    config.vm.box      = "ubuntu/trusty64"
    config.vm.hostname = "corpsee-com-server"

    config.vm.network :private_network, ip: "192.168.56.20"
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
        v.name = "default"
        vb.customize [
            "modifyvm", :id,
            "--name", "default",
            "--memory", "1024",
            "--natdnshostresolver1", "on",
            "--cpus", 1,
        ]
    end
    
    config.vm.provision "ansible" do |ansible|
        ansible.playbook       = "ansible/playbook.yml"
        ansible.inventory_path = "ansible/inventories/dev"
        ansible.limit          = 'all'
    end

    config.vm.provision "shell" do |s|
        s.path = "scripts/server-install.sh"
        s.args = "/vagrant"
    end

    config.vm.synced_folder "./", "/vagrant", type: "nfs"
end
