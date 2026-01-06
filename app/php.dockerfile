# ===============================
# Base PHP image
# ===============================
FROM php:8.2-fpm

# ===============================
# Install system dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
    unzip \
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
WORKDIR /var/www/html

# ===============================
# Copy application code
# ===============================
COPY ./app /var/www/html

# ===============================
# Ensure proper permissions
# ===============================
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# ===============================
# Expose app port
# ===============================
EXPOSE 8080

# ===============================
# Start PHP-FPM and Nginx
# ===============================
CMD ["sh", "-c", "service nginx start && php-fpm"]