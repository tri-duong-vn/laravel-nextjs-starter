
# FROM ubuntu:20.04
# WORKDIR /var/www/html

# COPY ./ /var/www/html/

# ENV DEBIAN_FRONTEND noninteractive
# ENV TZ=UTC

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN apt-get update \
#     && apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor sqlite3 libcap2-bin vim\
#     && mkdir -p ~/.gnupg \
#     && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
#     && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
#     && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
#     && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
#     && apt-get update \
#     && apt-get install -y php8.2-cli php8.2-dev \
#        php8.2-pgsql php8.2-sqlite3 php8.2-gd \
#        php8.2-curl php8.2-memcached \
#        php8.2-imap php8.2-mysql php8.2-mbstring \
#        php8.2-xml php8.2-zip php8.2-bcmath php8.2-soap \
#        php8.2-intl php8.2-readline \
#        php8.2-msgpack php8.2-igbinary php8.2-ldap \
#        php8.2-redis \
#     && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
#     && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
#     && apt-get install -y nodejs \
#     && apt-get -y autoremove \
#     && apt-get clean \
#     && apt-get install -y zsh \
#     && apt-get install -y wget \
#     && apt-get install -y php-xdebug \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
#     && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.2

# # Xdebug settings.
# COPY ./VM/xdebug.ini /etc/php/8.0/mods-available/xdebug.ini

# # Supervisor.
# # COPY ./VM/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# # Add admin user
# RUN useradd -ms /bin/bash -u 1337 admin

# RUN composer update

# # Make some ZSH configuration.
# ENV TERM xterm
# ENV ZSH_THEME agnoster

# # Expose ports.
# EXPOSE 8000
# EXPOSE 9000

# CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
FROM ubuntu:20.04

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor sqlite3 libcap2-bin \
    && mkdir -p ~/.gnupg \
    && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y php8.2-cli php8.2-dev \
       php8.2-pgsql php8.2-sqlite3 php8.2-gd \
       php8.2-curl php8.2-memcached \
       php8.2-imap php8.2-mysql php8.2-mbstring \
       php8.2-xml php8.2-zip php8.2-bcmath php8.2-soap \
       php8.2-intl php8.2-readline \
       php8.2-msgpack php8.2-igbinary php8.2-ldap \
       php8.2-redis \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y vim \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN apt-get update \
    && apt-get install -y php-xdebug

RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.2

# Xdebug settings.
COPY ./VM/xdebug.ini /etc/php/8.2/mods-available/xdebug.ini

COPY ./VM/php.ini /etc/php/8.2/cli/conf.d/php.ini
# RUN chmod +x /usr/local/bin/start-container

EXPOSE 8000
EXPOSE 9000

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
