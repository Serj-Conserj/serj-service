FROM certbot/certbot:latest

COPY certbot-entrypoint.sh /certbot-entrypoint.sh
# Ensure the entrypoint is executable
RUN chmod +x /certbot-entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/certbot-entrypoint.sh"]
