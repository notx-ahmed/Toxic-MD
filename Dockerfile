FROM node:lts-bookworm

# Install dependencies with mirror fix
RUN apt-get update && \
  apt-get install -y \
  git \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Setup directory
WORKDIR /root/toxic

# Install PM2 globally
RUN npm install pm2 -g

# Copy package files first for faster building
COPY package.json .
RUN npm install --legacy-peer-deps

# Copy rest of the files
COPY . .

EXPOSE 5000

# Start command
CMD ["npm", "start"]
