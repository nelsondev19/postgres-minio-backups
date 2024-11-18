#!/bin/sh
echo "Waiting for cronjob to run your database backup ⏳ -> ${CRON_SCHEDULE}"

crond -f
