# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0

# =========================
# BASE IMAGE (FIXED)
# =========================
FROM node:20 AS base

# =========================
# BUILDER STAGE
# =========================
FROM base AS builder

# Build dependencies for native modules
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

# Better CI/CD install method
RUN npm ci --omit=dev

# =========================
# RUNTIME IMAGE
# =========================
FROM base AS runtime

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY . .

EXPOSE 50051

ENTRYPOINT ["node", "index.js"]

# =========================
# GRPC HEALTH PROBE STAGE
# =========================
FROM runtime

ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18

RUN apt-get update && apt-get install -y wget \
    && wget -qO /bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 \
    && chmod +x /bin/grpc_health_probe \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
