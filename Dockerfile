FROM python:3.13-slim AS builder
LABEL maintainer="Affian Onn <affianonn@hotmail.com>"
LABEL org.opencontainers.image.source=https://github.com/argosenpaikun/nica-python-kube

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends gcc

COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

FROM python:3.13-slim

WORKDIR /app

COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .

RUN pip install --no-cache /wheels/*

# Create user and set ownershipe and permission as required
RUN adduser -D python-user && chown -R python-user:python-user /app
USER python-user