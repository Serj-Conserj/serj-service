#TODO: Reconsider Nginx version
FROM nginx:alpine

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the entrypoint and make it executable
COPY nginx-entrypoint.sh /nginx-entrypoint.sh
RUN chmod +x /nginx-entrypoint.sh

WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*

# Install bash for the bash-specific entrypoint
WORKDIR /
RUN apt-get update && apt-get install -y bash

ENTRYPOINT ["/bin/bash", "-c", "/nginx-entrypoint.sh"]

WORKDIR /usr/src/app
