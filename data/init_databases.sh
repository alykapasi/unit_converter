#!/bin/bash

# Create data directory if it doesn't exist
mkdir -p data

# Create databases with base data
echo "Creating databases with base data..."
for db in distance temperature mass speed force pressure currency; do
    rm -f "data/$db.db"
    sqlite3 "data/$db.db" < data/init_db.sql
done

# Add additional units and conversions
echo "Adding additional units and conversions..."
for db in distance temperature mass speed force pressure currency; do
    sqlite3 "data/$db.db" < "data/saturate_$db.sql"
done

echo "Databases initialized and saturated successfully!"

# Show some statistics
echo -e "\nDatabase Statistics:"
for db in distance temperature mass speed force pressure currency; do
    echo -e "\n$db database:"
    echo "Units:"
    sqlite3 "data/$db.db" "SELECT COUNT(*) FROM units;"
    echo "Conversions:"
    sqlite3 "data/$db.db" "SELECT COUNT(*) FROM conversions;"
done 