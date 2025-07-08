# Etapa de build con Node.js LTS
FROM node:18-alpine AS builder
WORKDIR /app

# Argumento para variable de entorno en build
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL

# Instalar dependencias
COPY package*.json ./
RUN npm ci

# Copiar código y construir
COPY . ./
RUN npm run build

# Etapa de producción
FROM node:18-alpine AS runner
WORKDIR /app

# Copiar artefactos de producción
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npm", "start"]
