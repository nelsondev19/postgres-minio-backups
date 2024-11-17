FROM alpine:3.20.3

WORKDIR /app

ARG MINIO_ENDPOINT
ARG ACCESS_KEY
ARG SECRET_KEY
ARG MINIO_BUCKET
ARG DATABASE_URL
ARG CRON_SCHEDULE

ENV MINIO_ENDPOINT=${MINIO_ENDPOINT}
ENV ACCESS_KEY=${ACCESS_KEY}
ENV SECRET_KEY=${SECRET_KEY}
ENV MINIO_BUCKET=${MINIO_BUCKET}
ENV DATABASE_URL=${DATABASE_URL}
ENV CRON_SCHEDULE=${CRON_SCHEDULE}

RUN apk add --no-cache postgresql-client minio-client

COPY ./run.sh .

RUN chmod +x run.sh

RUN mkdir /etc/cron

RUN echo "${CRON_SCHEDULE} /bin/sh /app/run.sh" > /etc/cron/crontab

RUN crontab /etc/cron/crontab

CMD ["crond", "-f"]