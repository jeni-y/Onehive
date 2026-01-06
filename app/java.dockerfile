# ===============================
# Base Java image
# ===============================
FROM eclipse-temurin:17-jdk

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
# Copy application code / JAR
# ===============================
COPY ./app/target/*.jar /app/app.jar

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
# Start Java app and Nginx
# ===============================
CMD ["sh", "-c", "service nginx start && java -jar /app/app.jar"]