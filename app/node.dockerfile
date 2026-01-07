# ===============================
# Base Node image
# ===============================
FROM node:20-alpine

# ===============================
# Install Nginx
# ===============================
RUN apk add --no-cache nginx

# ===============================
# Workdir
# ===============================
WORKDIR /app

# ===============================
# Copy application
# ===============================
COPY app/ /app/

# ===============================
# Install deps
# ===============================
RUN npm install

# ===============================
# Nginx config
# ===============================
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Expose port
# ===============================
EXPOSE 80

# ===============================
# Start app + nginx
# ===============================
CMD ["sh", "-c", "npm start & nginx -g 'daemon off;'"]