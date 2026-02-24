# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/ucudal/reto-summer-2026-ithaka-frontend.git . && git checkout <commit-hash>

RUN npm install --legacy-peer-deps

RUN npm run build

# ---------- Production stage ----------
FROM node:20

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]
