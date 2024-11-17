

Basic Usage

```bash
docker compose up
```

Backup Process
The container will:

1. Connect to MinIO using provided credentials

2. Create a PostgreSQL backup with timestamp

3. Upload the backup to the specified MinIO bucket

4. Remove the local backup file

5. Exit with appropriate status code (0 for success, 1 for failure)

Error Handling
The container will exit with status code 1 if any of these operations fail:

1. MinIO connection

2. Database backup creation

3. Upload to MinIO