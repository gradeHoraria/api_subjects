# Use a imagem base oficial do PHP com Apache
FROM php:7.4-apache

# Ative o módulo de reescrita do Apache
RUN a2enmod rewrite

# Instale as dependências necessárias
RUN apt-get update && apt-get install -y \
    libicu-dev \
    zlib1g-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala as extensões PHP necessárias
RUN docker-php-ext-install pdo pdo_mysql intl zip && docker-php-ext-configure intl

# Copie os arquivos do projeto para dentro do contêiner
COPY . /var/www/html

# Defina o diretório de trabalho
WORKDIR /var/www/html

# Instale as dependências do Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-plugins --no-scripts

# Cria o diretório de logs e define as permissões
RUN mkdir -p /var/www/html/logs && \
    chown -R www-data:www-data /var/www/html/logs

# Exponha a porta 80 para acessar o servidor web
EXPOSE 80
