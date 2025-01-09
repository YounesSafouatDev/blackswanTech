# Base Odoo image
FROM odoo:17.0

# Switch to root to install necessary tools
USER root

# Install curl (you don't need docker-compose inside the image)
RUN apt-get update && apt-get install -y curl make

# Switch back to odoo user for Odoo operations
USER odoo

# Copy your custom addons
COPY ./addons /mnt/extra-addons

# Copy your Odoo configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Copy the Makefile
COPY ./Makefile /mnt/extra-addons/Makefile

# Set the correct permissions (no ownership change)
USER root
RUN chmod -R 755 /mnt/extra-addons

# Default command to start Odoo
USER odoo
CMD ["odoo"]
