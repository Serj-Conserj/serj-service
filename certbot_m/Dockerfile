FROM certbot/certbot:latest

# Copy the entrypoint and make it executable
COPY certbot-entrypoint.sh /certbot-entrypoint.sh
RUN chmod +x /certbot-entrypoint.sh

# Install bash for bash-specific entrypoint (Alpine-based)
RUN apk update && apk add --no-cache bash

ENTRYPOINT ["/bin/bash", "-c", "/certbot-entrypoint.sh"]
