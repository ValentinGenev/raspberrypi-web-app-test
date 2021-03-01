#!/bin/bash

# apt-get -y update
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages curl software-properties-common mc gcc g++ make

# # NGINX installation
# add-apt-repository -y ppa:nginx/stable
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages nginx

# # PHP installation 
# apt-add-repository ppa:ondrej/php -y
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages php-fpm php-cli \
# php-curl php-sqlite3 php-gd \
# php-imap php-mysql php-mbstring \
# php-xml php-zip php-json php-bcmath \
# php-intl php-readline

# # Directories
# mkdir -p /var/www/artifacts/EMPTY
# ln -s /var/www/artifacts/EMPTY /var/www/vhosts
# chown -R www-data:www-data /var/www

# apt -y update
# apt -y upgrade
# apt -y autoremove
# apt -y clean

echo " ____                   _ "
echo "|  _ \  ___  _ __   ___| |"
echo "| | | |/ _ \| '_ \ / _ \ |"
echo "| |_| | (_) | | | |  __/_|"
echo "|____/ \___/|_| |_|\___/_|"
echo "|with the provisionning(_)"

#reboot
