Vagrant.configure("2") do |config|
    #config.vm.box      = "ubuntu/focal64"
    config.vm.box      = "ubuntu/jammy64"
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
        main.playbook           = "playbooks/web_server/main.yml"
        main.inventory_path     = "inventories/vagrant.yml"
        main.compatibility_mode = "2.0"
        main.limit              = 'all'
        main.verbose            = "vvv"
    end

    config.vm.provision "corpsee_site_symfony_init", type: "ansible", run: "never" do |corpsee_site_symfony_init|
        corpsee_site_symfony_init.playbook           = "playbooks/web_server/corpsee_site_symfony_init.yml"
        corpsee_site_symfony_init.inventory_path     = "inventories/vagrant.yml"
        corpsee_site_symfony_init.compatibility_mode = "2.0"
        corpsee_site_symfony_init.limit              = 'all'
        corpsee_site_symfony_init.verbose            = "vvv"
    end

    config.vm.provision "php_censor_init", type: "ansible", run: "never" do |php_censor_init|
        php_censor_init.playbook           = "playbooks/web_server/php_censor_init.yml"
        php_censor_init.inventory_path     = "inventories/vagrant.yml"
        php_censor_init.compatibility_mode = "2.0"
        php_censor_init.limit              = 'all'
        php_censor_init.verbose            = "vvv"
    end

    config.vm.provision "php_censor_test_init", type: "ansible", run: "never" do |php_censor_test_init|
        php_censor_test_init.playbook           = "playbooks/web_server/php_censor_test_init.yml"
        php_censor_test_init.inventory_path     = "inventories/vagrant.yml"
        php_censor_test_init.compatibility_mode = "2.0"
        php_censor_test_init.limit              = 'all'
        php_censor_test_init.verbose            = "vvv"
    end

    config.vm.provision "php_censor_site_init", type: "ansible", run: "never" do |php_censor_site_init|
        php_censor_site_init.playbook           = "playbooks/web_server/php_censor_site_init.yml"
        php_censor_site_init.inventory_path     = "inventories/vagrant.yml"
        php_censor_site_init.compatibility_mode = "2.0"
        php_censor_site_init.limit              = 'all'
        php_censor_site_init.verbose            = "vvv"
    end

    config.vm.provision "corpsee_site_symfony_release", type: "ansible", run: "never" do |corpsee_site_symfony_release|
        corpsee_site_symfony_release.playbook           = "playbooks/web_server/corpsee_site_symfony_release.yml"
        corpsee_site_symfony_release.inventory_path     = "inventories/vagrant.yml"
        if ENV['RELEASE_VERSION']
            corpsee_site_symfony_release.extra_vars = {
                corpsee_site_symfony_version: ENV['RELEASE_VERSION']
            }
        end
        corpsee_site_symfony_release.compatibility_mode = "2.0"
        corpsee_site_symfony_release.limit              = 'all'
        corpsee_site_symfony_release.verbose            = "vvv"
    end

    config.vm.provision "php_censor_release", type: "ansible", run: "never" do |php_censor_release|
        php_censor_release.playbook           = "playbooks/web_server/php_censor_release.yml"
        php_censor_release.inventory_path     = "inventories/vagrant.yml"
        if ENV['RELEASE_VERSION']
            php_censor_release.extra_vars = {
                php_censor_version: ENV['RELEASE_VERSION']
            }
        end
        php_censor_release.compatibility_mode = "2.0"
        php_censor_release.limit              = 'all'
        php_censor_release.verbose            = "vvv"
    end

    config.vm.provision "php_censor_test_release", type: "ansible", run: "never" do |php_censor_test_release|
        php_censor_test_release.playbook           = "playbooks/web_server/php_censor_test_release.yml"
        php_censor_test_release.inventory_path     = "inventories/vagrant.yml"
        if ENV['RELEASE_VERSION']
            php_censor_test_release.extra_vars         = {
                php_censor_version: ENV['RELEASE_VERSION']
            }
        end
        php_censor_test_release.compatibility_mode = "2.0"
        php_censor_test_release.limit              = 'all'
        php_censor_test_release.verbose            = "vvv"
    end

    config.vm.synced_folder "./", "/vagrant"
end
