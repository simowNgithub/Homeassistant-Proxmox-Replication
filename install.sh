chmod +x /usr/local/bin/replicate-homeassistant.sh
crontab -e
0 * * * * /usr/local/bin/replicate-homeassistant.sh
