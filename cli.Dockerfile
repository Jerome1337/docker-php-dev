# Composer
ENV COMPOSER_HOME /home/developer/.composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p ${COMPOSER_HOME}
RUN composer global require --prefer-dist --no-progress --no-interaction \
hirak/prestissimo \
pyrech/composer-changelogs \
sllh/composer-versions-check \
phpstan/phpstan-shim \
&& composer clear-cache

# PHAR binaries
ADD https://phar.phpunit.de/phpunit.phar /usr/local/bin/phpunit
ADD https://phar.phpunit.de/phpunit-old.phar /usr/local/bin/phpunit-old
ADD http://get.sensiolabs.org/php-cs-fixer-v2.phar /usr/local/bin/php-cs-fixer
ADD http://get.sensiolabs.org/php-cs-fixer-v1.phar /usr/local/bin/php-cs-fixer-1
RUN ln -s /home/developer/.composer/vendor/phpstan/phpstan-shim/phpstan.phar /usr/local/bin/phpstan

# Make all binaries executable
RUN chmod 755 /usr/local/bin/*

# Ruby gem (bundler and tools)
RUN gem install \
bundler \
yaml-lint

ADD home/.bashrc /home/developer/
