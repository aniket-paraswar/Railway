# Use the official PHP image as a base image
FROM php:8.1-apache

# Install MySQL/MariaDB client libraries and other dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmariadb-dev-compat \
    libmariadb-dev

# Enable Apache rewrite module
RUN a2enmod rewrite

# Install PHP extensions that your project requires
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mysqli

# Copy the project files into the container
COPY . /var/www/html/

# Set the working directory to the root of the app
WORKDIR /var/www/html

# Expose port 80 to make the web server accessible
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]
