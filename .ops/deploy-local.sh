#!/bin/bash
# DIR_ARTIFACT="/var/www/artifacts/${ARTIFACT}"

echo 'test'
echo $DIR_ARTIFACT
echo 'test'

mkdir -p $DIR_ARTIFACT
tar -xzvC $DIR_ARTIFACT -f /tmp/$ARTIFACT.tar.gz
touch "${DIR_ARTIFACT}/released.$(date '+%Y%m%d-%H%M')"
rm /tmp/$ARTIFACT.tar.gz

rm /var/www/vhosts
ln -s $DIR_ARTIFACT /var/www/vhosts
chown -R webbots:webbots /var/www/artifacts
chown -R webbots:webbots /var/www/vhosts
ls -lha /var/www/vhosts

# service php-fpm restart
# service nginx reload

echo " ____                   _ "
echo "|  _ \  ___  _ __   ___| |"
echo "| | | |/ _ \| '_ \ / _ \ |"
echo "| |_| | (_) | | | |  __/_|"
echo "|____/ \___/|_| |_|\___(_)"
