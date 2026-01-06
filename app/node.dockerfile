# ===============================
# Base Node.js image
# ===============================
FROM node:20

# ===============================
# Install system dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# Configure Nginx
# ===============================
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Set working directory
# ===============================
WORKDIR /usr/src/app

# ===============================
# Copy application code
# ===============================
COPY ./app /usr/src/app

# ===============================
# Install Node dependencies
# ===============================
RUN npm install --production

# ===============================
# Ensure proper permissions
# ===============================
RUN chown -R node:node /usr/src/app \
    && chmod -R 755 /usr/src/app

USER node

# ===============================
# Expose app port
# ===============================
EXPOSE 8080

# ===============================
# Start Node.js app and Nginx
# ===============================
CMD ["sh", "-c", "service nginx start && node server.js"]