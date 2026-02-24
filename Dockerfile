# ---------- Build stage ----------
FROM node:20-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git
RUN git clone https://github.com/ucudal/reto-summer-2026-ithaka-frontend.git .
RUN npm install --legacy-peer-deps
RUN npm run build

# ---------- Production stage ----------
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["npm", "start"]