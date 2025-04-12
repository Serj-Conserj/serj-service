#!/bin/bash

# Prevents Nginx from starting until the certs files are available
# while [ ! -f "/etc/letsencrypt/live/conserj.ru/fullchain.pem" ] || \
#       [ ! -f "/etc/letsencrypt/live/drone.conserj.ru/fullchain.pem" ]; do
#   echo "[WAIT] Some certificates missing. Attempting again..."
#   sleep 2
# done

DOMAINS=(
  "conserj.ru"
  "drone.conserj.ru"
)
CERT_PATH="/etc/letsencrypt/live"


# Function to check if certificates exist and are valid
check_certs() {
  if [ -d "$CERT_PATH/${DOMAIN[0]}" ]               &&
     [ -d "$CERT_PATH/${DOMAIN[1]}" ]               && 
     [ -f "$CERT_PATH/${DOMAIN[0]}/fullchain.pem" ] && 
     [ -f "$CERT_PATH/${DOMAIN[0]}/privkey.pem" ]   &&
     [ -f "$CERT_PATH/${DOMAIN[1]}/fullchain.pem" ] && 
     [ -f "$CERT_PATH/${DOMAIN[1]}/privkey.pem" ]; then
    return 0
  else
    return 1
  fi
}


# If no certs, start with HTTP-only config
if !check_certs; then
  echo "[ISSUE] Certificates not found. Start with HTTP-only config."
  cp /nginx-http.conf /etc/nginx/conf.d/default.conf
  nginx -g 'daemon off;' # Run Nginx with global directives and daemon off

  while !check_certs; do
    echo "[WAIT] Certificates not found. Waiting 5sec..."
    sleep 5
  done

  echo "[DONE] Certificates detected. Switching to HTTPS config..."
  cp /etc/nginx/nginx-https.conf /etc/nginx/conf.d/default.conf
  nginx -s reload

else
  echo "[OK] Certificates found. Start with HTTPS config."
  cp /nginx-https.conf /etc/nginx/conf.d/default.conf
  nginx -g 'daemon off;'
fi

#TODO: Add certs renewal checking 24h loop
