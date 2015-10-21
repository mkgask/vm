Vagrant.configure(2) do |config|
    config.vm.box = "debian/jessie64"
    config.vm.network "private_network", ip: "192.168.33.11"
    config.vm.synced_folder ".", "/vagrant", id: "core", :nfs => true, :mount_options => ['nolock,vers=3,udp']

    config.vm.provision "shell", path: "vagrant_provision.sh"

    config.vm.provision "docker" do |d|
        d.build_image "/vagrant", args:"-t vm"
        d.run "vm", args: "-d -p 80:80 -p 2812:2812 -v '/vagrant:/vagrant'"
    end
end
