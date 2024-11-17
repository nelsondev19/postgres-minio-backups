#!/bin/bash

dotenv() {
  set -a
  [ -f .env ] && source .env  # Use 'source' instead of '.' for better portability
  set +a
}

dotenv

echo "Using cronjob -> ${CRON_SCHEDULE}"

echo "Connecting to Minio 💾"

# Capture command output and check for errors
mcli_alias_output=$(mcli alias set myminio $MINIO_ENDPOINT $ACCESS_KEY $SECRET_KEY 2>&1)
if [[ $? -ne 0 ]]; then
  echo "Error connecting to Minio: $mcli_alias_output"
  exit 1
fi

echo "Starting PostgreSQL database backup ⏳"

# Capture timestamp generation and check for errors
timestamp=$(date +"%m_%d_%Y_%H_%M_%S" 2>&1)
if [[ $? -ne 0 ]]; then
  echo "Error generating timestamp"
  exit 1
fi

filename=backup_${timestamp}.bak

# Capture pg_dump output and check for errors
pg_dump_output=$(pg_dump -Fc -v -d $DATABASE_URL -f $filename 2>&1)
if [[ $? -ne 0 ]]; then
  echo "Error during database backup: $pg_dump_output"
  exit 1
fi

echo "Backup completed successfully 🎉"

echo "Uploading to Minio "

# Capture mcli output and check for errors
mcli_upload_output=$(mcli cp $filename myminio/${MINIO_BUCKET} 2>&1)
if [[ $? -ne 0 ]]; then
  echo "Error uploading to Minio: $mcli_upload_output"
  exit 1
fi

echo "Upload completed successfully 🎉"

rm $filename

echo "All tasks completed ✅"