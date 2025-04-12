# Prevents Nginx from starting until the certs files are available
while [ ! -f "/etc/letsencrypt/live/conserj.ru/fullchain.pem" ] || \
      [ ! -f "/etc/letsencrypt/live/drone.conserj.ru/fullchain.pem" ]; do
  echo "[WAIT] Some certificates missing. Attempting again..."
  sleep 2
done

# Run Nginx with global directives and daemon off
nginx -g 'daemon off'
