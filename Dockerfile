FROM python:3.13.3-slim AS builder
LABEL maintainer="Affian Onn <affianonn@hotmail.com>"
LABEL org.opencontainers.image.source=https://github.com/argosenpaikun/nica-python-kube

WORKDIR /app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY src src

# Create user and set ownership and permission as required
RUN groupadd -g 1234 python-group && useradd -m -u 1234 -g python-group python-user && \
    chown -R python-user:python-group /app

# Switch to python-user
USER python-user

EXPOSE 3000

CMD ["python", "src/main.py"]