#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "Updating SO"
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get -y install lsb-release adduser unzip libnss-resolve

echo "Updating NSSwitch to allow mdns subdomains"
sudo sed -i 's/mdns4_minimal/mdns4/g' /etc/nsswitch.conf
sudo bash -c "cat > /etc/mdns.allow" <<'EOF'
.local.
.local
EOF

echo "Replacing motd message"
cat /tmp/motd | sudo tee /etc/motd
sudo chmod 644 /etc/motd 
sudo rm -f /tmp/motd

echo "Installing scripts"
sudo mv /tmp/get-ips.sh /usr/bin/
chmod +x /usr/bin/get-ips.sh

sudo mkdir -p /usr/local/share/vagrant-plugins/
sudo mv /tmp/*-vagrantfile-embedded-plugins.rb /usr/local/share/vagrant-plugins/
sudo chmod +r /usr/local/share/vagrant-plugins/*-vagrantfile-embedded-plugins.rb

mkdir -p /tmp/scripts-to-run/