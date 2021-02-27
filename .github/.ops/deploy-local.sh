#!/bin/bash
# DIR_ARTIFACT="/var/www/artifacts/${ARTIFACT}"

# sudo mkdir -p $DIR_ARTIFACT
# sudo tar -xzvC $DIR_ARTIFACT -f /tmp/$ARTIFACT.tar.gz
# sudo touch "${DIR_ARTIFACT}/released.$(date '+%Y%m%d-%H%M')"
# sudo rm /tmp/$ARTIFACT.tar.gz

# sudo rm /var/www/vhosts
# sudo ln -s $DIR_ARTIFACT /var/www/vhosts
# sudo chown -R www-data:www-data /var/www/artifacts
# sudo chown -R www-data:www-data /var/www/vhosts
# sudo ls -lha /var/www/vhosts

# sudo service php-fpm restart
# sudo service nginx reload

echo " ____                   _ "
echo "|  _ \  ___  _ __   ___| |"
echo "| | | |/ _ \| '_ \ / _ \ |"
echo "| |_| | (_) | | | |  __/_|"
echo "|____/ \___/|_| |_|\___(_)"
