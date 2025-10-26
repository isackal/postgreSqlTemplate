#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo -e "${RED}Error: .env file not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Starting database deployment...${NC}"
echo ""

# Create a temporary SQL file that combines everything in a transaction
TEMP_SQL=$(mktemp)
TEMP_OUTPUT=$(mktemp)
trap "rm -f $TEMP_SQL $TEMP_OUTPUT" EXIT

# Start transaction
echo "BEGIN;" > "$TEMP_SQL"

# Add extensions
echo "-- Deploying extensions..." >> "$TEMP_SQL"
cat extensions.sql >> "$TEMP_SQL"
echo "" >> "$TEMP_SQL"

# Deploy schemas
echo "-- Deploying schemas..." >> "$TEMP_SQL"
for file in src/schemas/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Deploy tables
echo "-- Deploying tables..." >> "$TEMP_SQL"
for file in src/tables/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Deploy functions
echo "-- Deploying functions..." >> "$TEMP_SQL"
for file in src/functions/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Deploy views
echo "-- Deploying views..." >> "$TEMP_SQL"
for file in src/views/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Deploy indexes
echo "-- Deploying indexes..." >> "$TEMP_SQL"
for file in src/indexes/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Deploy triggers
echo "-- Deploying triggers..." >> "$TEMP_SQL"
for file in src/triggers/*.sql; do
    if [ -f "$file" ]; then
        echo "-- From: $file" >> "$TEMP_SQL"
        cat "$file" >> "$TEMP_SQL"
        echo "" >> "$TEMP_SQL"
    fi
done

# Commit transaction
echo "COMMIT;" >> "$TEMP_SQL"

# Execute the transaction and colorize output
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f "$TEMP_SQL" 2>&1 | while IFS= read -r line; do
    if echo "$line" | grep -qi "error\|failed\|fatal"; then
        echo -e "${RED}${line}${NC}"
    elif echo "$line" | grep -qi "warning"; then
        echo -e "${YELLOW}${line}${NC}"
    else
        echo "$line"
    fi
done

EXIT_CODE=${PIPESTATUS[0]}

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ Database deployment completed successfully!${NC}"
    exit 0
else
    echo -e "${RED}✗ Database deployment failed!${NC}"
    echo -e "${RED}All changes have been rolled back.${NC}"
    exit 1
fi
