# Postgres Minio backups

A Docker to backup your PostgreSQL database to Minio via a cron.

## Overview

The template use Docker and Bash Scripting to dump your PostgreSQL data to a file and then upload the file to Minio.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/template/7VQo0T)

## Configuration

- `MINIO_ENDPOINT` - Minio endpoint. Example: `http://minio:9000`.

- `ACCESS_KEY` - Minio access key.

- `SECRET_KEY` - Minio secret key.

- `MINIO_BUCKET` - Minio bucket. Example `my-bucket`.

- `BACKUP_DATABASE_URL` - The connection string of the database to backup. Example: `"postgresql://username:password@host:port/database"`

- `CRON_SCHEDULE` - The cron schedule to run the backup on. Example: `0 5 * * *` the cron runs at 5 AM every day
