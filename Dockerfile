# Base Odoo image
FROM odoo:17.0

# Switch to root to install packages
USER root

# Install necessary tools
RUN apt-get update && apt-get install -y curl make && \
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Switch back to odoo user for Odoo operations
USER odoo

# Copy your custom addons
COPY ./addons /mnt/extra-addons

# Copy your Odoo configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Copy the docker-compose.yml file to /mnt/extra-addons
COPY ./docker-compose.yml /mnt/extra-addons/docker-compose.yml

# Copy your Makefile
COPY ./Makefile /mnt/extra-addons/Makefile

# Set the correct permissions (no ownership change)
USER root
RUN chmod -R 755 /mnt/extra-addons

# Default command to start Odoo
USER odoo
CMD ["odoo"]
