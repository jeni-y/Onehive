# ===============================
# Base Java image
# ===============================
FROM eclipse-temurin:17-jdk

# ===============================
# Install Nginx
# ===============================
RUN apt-get update && apt-get install -y \
    nginx \
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
# Build Java app
# ===============================
RUN ./mvnw package -DskipTests

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
CMD ["sh", "-c", "java -jar target/*.jar & nginx -g 'daemon off;'"]