#!/bin/bash

EMAIL="gromaks000@gmail.com"
DOMAINS=(
    "conserj.ru"
    "drone.conserj.ru"
)
CERT_PATH="/etc/letsencrypt/live"


for i in "${!DOMAINS[@]}"; do
    DOMAIN="${DOMAINS[$i]}"

    if [ -d "$CERT_PATH/$DOMAIN" ]              &&
       [ -f "$CERT_PATH/$DOMAIN/fullchain.pem" ] &&
       [ -f "$CERT_PATH/$DOMAIN/privkey.pem" ]; then
        echo "[OK] Certificate for $DOMAIN already exists. Skipping issuance."
    else
        echo "[INFO] No certificates found for $DOMAIN. Attempting to issue..."
        certbot certonly --webroot --webroot-path /var/www/certbot \
            --email "$EMAIL" \
            --agree-tos \
            --no-eff-email \
            -d "$DOMAIN"
    fi
done

# Certs renewal loop
echo "[INFO] Starting certificate renewal loop..."
while true; do
    certbot renew --webroot --webroot-path /var/www/certbot
    echo "[OK] Renewal check complete. Sleeping for 24 hours..."
    sleep 24h
done
