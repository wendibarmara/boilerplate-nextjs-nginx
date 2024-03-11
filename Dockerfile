# Dockerfile
# preferred node version chosen here (LTS = 18.18 as of 10/10/23)
FROM node:18.17.0-alpine AS builder

# Create the directory on the node image
# where our Next.js app will live
RUN mkdir -p /app

# Set /app as the working directory in container
WORKDIR /app

# Copy package.json and package-lock.json
# to the /app working directory
COPY package*.json ./


# Install dependencies in /app
RUN npm install 



# Copy the rest of our Next.js folder into /app
COPY . .

RUN npm run build

FROM node:18.17.0-alpine

WORKDIR /app

# Copy built files from the builder stage
COPY --from=builder /app .

# Ensure port 8080 is accessible to our system
EXPOSE 8080

# Run dev, as we would via the command line
CMD npm run start