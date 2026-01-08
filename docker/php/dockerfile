# ===============================
# Base image
# ===============================
FROM php:8.2-fpm

# ===============================
# Install system dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mysqli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# Install Composer
# ===============================
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# ===============================
# Set working directory
# ===============================
WORKDIR /var/www/html

# ===============================
# Copy client application code
# ===============================
COPY app/ /var/www/html/

# ===============================
# Install PHP dependencies (if composer.json exists)
# ===============================
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

# ===============================
# Configure Nginx
# ===============================
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Set permissions
# ===============================
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# ===============================
# Expose HTTP port
# ===============================
EXPOSE 80

# ===============================
# Start PHP-FPM and Nginx
# ===============================
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]