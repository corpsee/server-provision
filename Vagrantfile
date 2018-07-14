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

    config.vm.provision "main", type: "ansible" do |main|
        main.playbook           = "playbooks/web_server.yml"
        main.inventory_path     = "inventories/vagrant.yml"
        main.compatibility_mode = "2.0"
        main.limit              = 'all'
        main.verbose            = "v"
    end

    config.vm.provision "corpsee_site_release", type: "ansible", run: "never" do |corpsee_site_release|
        corpsee_site_release.playbook           = "playbooks/corpsee_site_release.yml"
        corpsee_site_release.inventory_path     = "inventories/vagrant.yml"
        corpsee_site_release.compatibility_mode = "2.0"
        corpsee_site_release.limit              = 'all'
        corpsee_site_release.verbose            = "v"
    end

    config.vm.provision "php_censor_release", type: "ansible", run: "never" do |php_censor_release|
        php_censor_release.playbook           = "playbooks/php_censor_release.yml"
        php_censor_release.inventory_path     = "inventories/vagrant.yml"
        php_censor_release.compatibility_mode = "2.0"
        php_censor_release.limit              = 'all'
        php_censor_release.verbose            = "v"
    end

    config.vm.synced_folder "./", "/vagrant"
end
