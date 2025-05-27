#!/bin/bash

DOMAINS=(
  "conserj.ru"
  "drone.conserj.ru"
)
CERT_PATH="/etc/letsencrypt/live"


# Checks if certificates exist
check_certs() {
  if [ -d "$CERT_PATH/${DOMAINS[0]}" ]               &&
     [ -d "$CERT_PATH/${DOMAINS[1]}" ]               && 
     [ -f "$CERT_PATH/${DOMAINS[0]}/fullchain.pem" ] && 
     [ -f "$CERT_PATH/${DOMAINS[0]}/privkey.pem" ]   &&
     [ -f "$CERT_PATH/${DOMAINS[1]}/fullchain.pem" ] && 
     [ -f "$CERT_PATH/${DOMAINS[1]}/privkey.pem" ]; then
    return 0
  else
    return 1
  fi
}


# If no certs, start with HTTP-only config
if ! check_certs; then
  echo "[INFO] Certificates not found. Start with HTTP-only config."
  cp /nginx-http.conf /etc/nginx/conf.d/default.conf
  nginx # Run in the background

  while ! check_certs; do
    echo "[INFO] Certificates not found. Sleeping 10sec..."
    sleep 10
  done

  echo "[OK] Certificates detected. Switching to HTTPS config..."
  cp /etc/nginx/nginx-https.conf /etc/nginx/conf.d/default.conf
  nginx -s reload

  # Keep the container running
  nginx -g 'daemon off;'

else
  echo "[OK] Certificates found. Start with HTTPS config."
  cp /nginx-https.conf /etc/nginx/conf.d/default.conf
  nginx -g 'daemon off;'
fi
