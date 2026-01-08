# ===============================
# Base Python image
# ===============================
FROM python:3.11-slim

# ===============================
# Install dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# Workdir
# ===============================
WORKDIR /app

# ===============================
# Copy application
# ===============================
COPY app/ /app/

# ===============================
# Install Python deps
# ===============================
RUN pip install --no-cache-dir -r requirements.txt

# ===============================
# Nginx config
# ===============================
RUN rm -f /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ===============================
# Expose port
# ===============================
EXPOSE 80

# ===============================
# Start app + nginx
# ===============================
CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:8000 & nginx -g 'daemon off;'"]