FROM alpine:3.20.3

WORKDIR /app


ENV MINIO_ENDPOINT=""
ENV ACCESS_KEY=""
ENV SECRET_KEY=""
ENV MINIO_BUCKET=""
ENV DATABASE_URL=""
ENV CRON_SCHEDULE=""

RUN apk add --no-cache postgresql-client minio-client

COPY ./run.sh .

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

RUN chmod +x run.sh

ENTRYPOINT ["/app/entrypoint.sh"]