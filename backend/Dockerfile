FROM node:23-slim as build
WORKDIR /app

# Install MariaDB client
RUN apt-get update && apt-get install -y mariadb-client && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]