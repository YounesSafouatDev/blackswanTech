# Base Odoo image
FROM odoo:17.0

# Switch to root to install packages
USER root

# Install necessary tools
RUN apt-get update && apt-get install -y curl make \
    && apt-get remove --purge -y libnode-dev libnode72 \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g less node-sass \
    && apt-get clean

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
