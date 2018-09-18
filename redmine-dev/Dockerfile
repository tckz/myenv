FROM centos:7

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
    chmod +x /tini && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --verify /tini.asc
ENTRYPOINT ["/tini", "--"]

COPY fs /

RUN set -x && \
	yum install -y epel-release yum-utils centos-release-scl-rh centos-release-scl which && \
	yum-config-manager --enable epel && \
	yum install -y git rh-ruby24 rh-ruby24-ruby-devel rh-ruby24-rubygem-bundler && \
	yum install -y libffi-devel gcc make ImageMagick-devel sqlite-devel graphviz "ipa-*-fonts" && \
	rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm && \
	yum install -y --disablerepo="*" --enablerepo=mysql57-community mysql-community-devel


EXPOSE 3000

CMD scl enable rh-ruby24 "cd /redmine && exec bundle exec rails s -b 0.0.0.0"

