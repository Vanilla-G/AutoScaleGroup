#!/bin/bash
apt update -y
apt remove -y apache2
apt autoremove -y
apt install -y apache2 php mysql-server php-mysql

systemctl start apache2
systemctl enable apache2

usermod -a -G www-data ubuntu-user  # Replace "ubuntu-user" with your Ubuntu username
chown -R ubuntu-user:www-data /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

cd /var/www/html
curl http://169.254.169.254/latest/meta-data/instance-id -o index.html
curl https://raw.githubusercontent.com/hashicorp/learn-terramino/master/index.php -O
