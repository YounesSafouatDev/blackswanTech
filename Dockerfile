# Base Odoo image
FROM odoo:17.0

# Copy your custom addons
COPY ./addons /mnt/extra-addons

# Copy your Odoo configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Set permissions (if needed)
RUN chmod -R 755 /mnt/extra-addons /etc/odoo/odoo.conf

# Default command to start Odoo
CMD ["odoo"]
