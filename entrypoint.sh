#!/bin/sh

mkdir /etc/cron

echo "${CRON_SCHEDULE} /bin/sh /app/run.sh" > /etc/cron/crontab

crontab /etc/cron/crontab

echo "Waiting for cronjob to run your database backup ⏳ -> ${CRON_SCHEDULE}"

crond -f
