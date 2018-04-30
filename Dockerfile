FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
    vim \
    git \
    wget \
    unzip \
    libicu-dev \
    libpng-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libjpeg-dev \
    cron \
    logrotate \
    nodejs \
    npm \
    ca-certificates \
    openssl \
    zlib1g-dev \
    imagemagick \
    ghostscript \
    autoconf \
    libpcre3-dev \
    libtool \
    gcc \
    make \
    g++ \
    python \
    libffi-dev \
    ruby \
    ruby-dev \
    libxml2-dev \
    libpq-dev

RUN gem install sass compass --no-ri --no-rdoc

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install iconv pdo pdo_mysql pdo_pgsql pgsql mysqli mbstring intl json gd mcrypt zip bcmath pcntl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# install dependencies
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install gulp-cli -g 
RUN npm install gulp -D
RUN npm install -g bower bower-npm-resolver

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN "date"

WORKDIR /var/www
