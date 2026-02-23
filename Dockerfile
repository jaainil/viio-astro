FROM oven/bun:1-alpine AS base

FROM base AS deps
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN bun run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production

RUN addgroup -g 1001 nodejs && \
    adduser -u 1001 -G nodejs -D astro

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

RUN bun add -g serve

USER astro

EXPOSE 4321
CMD ["serve", "-s", "dist", "-l", "4321"]
