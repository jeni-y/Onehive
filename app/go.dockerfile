# ===============================
# Base Go image
# ===============================
FROM golang:1.21

# ===============================
# Install dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# Workdir
# ===============================
WORKDIR /app

# ===============================
# Copy Go app
# ===============================
COPY app/ /app/

# ===============================
# Build Go binary
# ===============================
RUN go mod tidy && go build -o server

# ===============================
# Nginx config
# ===============================
RUN rm -f /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Expose Nginx port
# ===============================
EXPOSE 80

# ===============================
# Start Go + Nginx correctly
# ===============================
CMD ["sh", "-c", "./server & nginx -g 'daemon off;'"]