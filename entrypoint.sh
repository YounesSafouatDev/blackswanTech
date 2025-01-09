#!/bin/bash

# Initialize the database if it's not already initialized
if [ "$(psql -h $DB_HOST -U $DB_USER -t -c "SELECT 1 FROM pg_database WHERE datname='bst'")" != "1" ]; then
  echo "Database not initialized. Initializing now..."
  odoo -d bst -i base --db_host=$DB_HOST --db_user=$DB_USER --db_password=$DB_PASSWORD --without-demo=all --stop-after-init
else
  echo "Database already initialized."
fi

# Start Odoo server
exec "$@"
