#!/bin/bash

dotenv() {
  set -a
  [ -f .env ] && source .env  # Use 'source' instead of '.' for better portability
  set +a
}

dotenv

echo "Using cronjob -> ${CRON_SCHEDULE}"

echo "Connecting to Minio 💾"

mcli alias set myminio $MINIO_ENDPOINT $ACCESS_KEY $SECRET_KEY

echo "Starting PostgreSQL database backup ⏳"

timestamp=$(date +"%m_%d_%Y_%H_%M_%S")

filename=backup_${timestamp}.bak

pg_dump -Fc -v -d $DATABASE_URL -f $filename

echo "Backup completed successfully 🎉"

echo "Uploading to Minio "

mcli cp $filename myminio/${MINIO_BUCKET}

echo "Upload completed successfully 🎉"

rm $filename

echo "All tasks completed ✅"