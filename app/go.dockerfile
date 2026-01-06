# ===============================
# Base Go image
# ===============================
FROM golang:1.21

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
# Set working directory
# ===============================
WORKDIR /app

# ===============================
# Copy application code
# ===============================
COPY ./app /app

# ===============================
# Build the Go binary
# ===============================
RUN go mod tidy && go build -o server .

# ===============================
# Configure Nginx
# ===============================
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Expose app port
# ===============================
EXPOSE 8080

# ===============================
# Start Go binary and Nginx
# ===============================
CMD ["sh", "-c", "service nginx start && ./server"]