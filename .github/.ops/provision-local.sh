#!/bin/bash

# Directories
mkdir -p /var/www/artifacts/EMPTY
ln -s /var/www/artifacts/EMPTY /var/www/vhost
chown -R webbots:webbots /var/www

echo " ____                   _ "
echo "|  _ \  ___  _ __   ___| |"
echo "| | | |/ _ \| '_ \ / _ \ |"
echo "| |_| | (_) | | | |  __/_|"
echo "|____/ \___/|_| |_|\___/_|"
echo "|with the provisionning(_)"
