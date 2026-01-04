
#!/bin/bash

# Home Assistant Webhook-Konfiguration
HA_URL="http://10.10.10.20:8123/api/webhook"
WEBHOOK_STOP="-FTb5gs4iFiX0j-shutdown"
WEBHOOK_START="xxxxx"

# Logdatei im Original-Proxmox-Stil
LOG="/var/log/pve/replication/100-0.log"

# Start-Eintrag
echo "$(date '+%Y-%m-%d %H:%M:%S') 100-0: start replication job (triggered via webhook script)" >> "$LOG"

# MariaDB stoppen
echo "$(date '+%Y-%m-%d %H:%M:%S') 100-0: stopping MariaDB via webhook" >> "$LOG"
curl -s -X POST "$HA_URL/$WEBHOOK_STOP"

# Kurze Wartezeit
sleep 5

# Replikation ausführen
echo "$(date '+%Y-%m-%d %H:%M:%S') 100-0: running pvesr job" >> "$LOG"
pvesr run --id 100-0 >> "$LOG" 2>&1

# MariaDB wieder starten
echo "$(date '+%Y-%m-%d %H:%M:%S') 100-0: starting MariaDB via webhook" >> "$LOG"
curl -s -X POST "$HA_URL/$WEBHOOK_START"

# Abschluss-Eintrag
echo "$(date '+%Y-%m-%d %H:%M:%S') 100-0: end replication job" >> "$LOG"

