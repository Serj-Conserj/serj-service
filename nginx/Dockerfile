#TODO: Reconsider Nginx version
FROM nginx:alpine

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY nginx-entrypoint.sh /nginx-entrypoint.sh
# Ensure the entrypoint is executable
RUN chmod +x /nginx-entrypoint.sh

WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*

ENTRYPOINT ["/bin/bash", "-c", "/nginx-entrypoint.sh"]

WORKDIR /usr/src/app
