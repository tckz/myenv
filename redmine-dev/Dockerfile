FROM centos:7

ENV TINI_VERSION v0.15.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
    chmod +x /tini && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --verify /tini.asc
COPY license /license
ENTRYPOINT ["/tini", "--"]

RUN set -x && \
	yum install -y epel-release yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y git tcsh vim-enhanced iproute bind-utils ruby ruby-devel && \
	yum install -y libffi-devel gcc make ImageMagick-devel sqlite-devel rubygem-json graphviz-ruby && \
	gem install bundler

EXPOSE 3000

CMD cd /redmine && exec bundle exec rails s -b 0.0.0.0

