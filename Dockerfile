# Base Odoo image
FROM odoo:17.0

# Install make and other necessary tools
RUN apt-get update && apt-get install -y make

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
