
#!/bin/bash
# echo "Installing Nginx..."
# sudo apt-get install -y nginx
# sudo systemctl enable nginx
# echo "Setup complete."

#!/bin/bash
set -e

echo "-------------------------------------"
echo "Updating system and installing base packages"
echo "-------------------------------------"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl git vim htop ufw

echo "-------------------------------------"
echo "Security Hardening"
echo "-------------------------------------"

# Disable root SSH login
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Enable firewall and allow SSH + HTTP/HTTPS
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

echo "-------------------------------------"
echo "Performance Tuning"
echo "-------------------------------------"

# sysctl tuning
echo "fs.file-max = 100000" | sudo tee -a /etc/sysctl.conf
echo "net.core.somaxconn = 1024" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# ulimit for file descriptors
echo "* hard nofile 65535" | sudo tee -a /etc/security/limits.conf
echo "* soft nofile 65535" | sudo tee -a /etc/security/limits.conf

echo "-------------------------------------"
echo "Setup Complete"
echo "-------------------------------------"

