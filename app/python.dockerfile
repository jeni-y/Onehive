# ===============================
# Base Python image
# ===============================
FROM python:3.12-slim

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
WORKDIR /app

# ===============================
# Copy application code
# ===============================
COPY ./app /app

# ===============================
# Install Python dependencies
# ===============================
RUN pip install --no-cache-dir -r requirements.txt

# ===============================
# Ensure proper permissions
# ===============================
RUN chown -R www-data:www-data /app \
    && chmod -R 755 /app

# ===============================
# Expose app port
# ===============================
EXPOSE 8080

# ===============================
# Start app with Gunicorn and Nginx
# ===============================
CMD ["sh", "-c", "service nginx start && gunicorn -w 4 -b 0.0.0.0:8080 app:app"]