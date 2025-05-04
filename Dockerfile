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
COPY src /app/src

RUN pip install --no-cache /wheels/*

# Create user and set ownership and permission as required
RUN groupadd -g 1234 python-group && useradd -m -u 1234 -g python-group python-user && \
    chown -R python-user:python-group /app

# Switch to python-user
USER python-user

EXPOSE 3000

CMD [ "python", "src/main.py" ]