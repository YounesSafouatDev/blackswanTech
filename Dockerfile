# Base Odoo image
FROM odoo:17.0

# Switch to root to install packages
USER root

# Install make and other necessary tools
RUN apt-get update && apt-get install -y make

# Switch back to odoo user
USER odoo

# Copy your custom addons
COPY ./addons /mnt/extra-addons

# Copy your Odoo configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Set permissions (ignore errors for mounted volumes)
RUN chmod -R --no-preserve-root 755 /mnt/extra-addons /etc/odoo/odoo.conf || true

# Run make up
RUN make up

# Initialize Odoo
RUN odoo-init

# Default command to start Odoo
CMD ["odoo"]
