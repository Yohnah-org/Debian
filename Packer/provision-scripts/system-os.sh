#!/bin/sh

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

echo "Installing Avahi-Daemon for ZeroConf DNS resolving"
sudo apt-get -y install avahi-daemon avahi-utils
sudo mv /tmp/dns /usr/local/bin

echo "Replacing motd message"
cat /tmp/motd | sudo tee /etc/motd
sudo chmod 644 /etc/motd 
sudo rm -f /tmp/motd

echo "Installing scripts"
sudo mv /tmp/get-ips.sh /usr/bin/
chmod +x /usr/bin/get-ips.sh

sudo mv /tmp/*-vagrantfile-embedded-plugins.rb /usr/local/share
sudo chmod +r /usr/local/share/*-vagrantfile-embedded-plugins.rb