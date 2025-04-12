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

# Install bash for bash-specific entrypoint (Alpine-based)
WORKDIR /
RUN apk update && apk add --no-cache bash

ENTRYPOINT ["/bin/bash", "-c", "/nginx-entrypoint.sh"]

WORKDIR /usr/src/app
