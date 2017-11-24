FROM amazonlinux

# 利用するdocker環境でまだ--initが使えない
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
	chmod +x /tini && \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
	gpg --verify /tini.asc

ENTRYPOINT ["/tini", "--", "/root/boot.sh"]

RUN set -x && \
	yum install -y epel-release yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y redis ruby tcsh iproute bind-utils 

RUN gem install --version 3.2.2 redis

COPY fs /

CMD ["cluster"]

