FROM amazonlinux

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
	chmod +x /tini && \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
	gpg --verify /tini.asc

# Amazon repoのphpをdisable指定したyum.repos.d
COPY fs0 /

RUN set -x && \
	yum install -y epel-release yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y --disablerepo="*" --enablerepo=epel libwebp && \
	yum install -y curl nginx tcsh && \
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
	yum-config-manager --enable remi-php70 && \
	yum install -y php php-cli php-fpm php-gd php-mysqlnd php-json php-xml php-mbstring php-pecl-zip php-mcrypt && \
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer 

EXPOSE 8000:8000

COPY fs1 /

ENTRYPOINT ["/tini", "--"]
CMD /var/www/mysession/perm.sh && php-fpm && nginx -g "daemon off;"

