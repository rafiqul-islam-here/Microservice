# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0

# =========================
# BASE IMAGE (FIXED)
# =========================
FROM node:20.2.0 AS base

# =========================
# BUILDER STAGE
# =========================
FROM base AS builder

# Native build dependencies (Debian-based)
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

# Better CI/CD install
RUN npm ci --omit=dev

# =========================
# RUNTIME STAGE
# =========================
FROM base AS without-grpc-health-probe-bin

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules

COPY . .

EXPOSE 7000

ENTRYPOINT ["node", "server.js"]

# =========================
# GRPC HEALTH PROBE
# =========================
FROM without-grpc-health-probe-bin

ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18

RUN wget -qO /bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 \
    && chmod +x /bin/grpc_health_probe
