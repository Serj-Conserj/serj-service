FROM certbot/certbot:latest

# Copy the entrypoint and make it executable
COPY certbot-entrypoint.sh /certbot-entrypoint.sh
RUN chmod +x /certbot-entrypoint.sh

# Install bash for the bash-specific entrypoint
RUN apt-get update && apt-get install -y bash

ENTRYPOINT ["/bin/bash", "-c", "/certbot-entrypoint.sh"]
