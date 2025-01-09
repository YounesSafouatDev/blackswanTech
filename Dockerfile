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

# Copy your Makefile
COPY ./Makefile /mnt/extra-addons/Makefile

# Switch to root to set permissions correctly
USER root
RUN chown -R root:root /mnt/extra-addons && chmod -R 755 /mnt/extra-addons

# Run make up to bring up services (will start containers in detached mode)
RUN make -C /mnt/extra-addons up

# Initialize the database with the base module
RUN make -C /mnt/extra-addons init-db

# Default command to start Odoo
USER odoo
CMD ["odoo"]
