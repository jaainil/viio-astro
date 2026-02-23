FROM oven/bun:1.1 AS base
WORKDIR /app

# Install dependencies
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Build the application
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN bun run build

# Production runner
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy built assets
COPY --from=builder /app/dist ./dist

# Install a simple static server
RUN bun install -g serve

# Set non-root user
USER bun

EXPOSE 4321

# Serve the application
CMD ["serve", "dist", "-l", "4321", "-s"]
