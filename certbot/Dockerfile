FROM amazonlinux


RUN set -x && \
	yum install -y epel-release && \
	yum install -y yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y tcsh vim-enhanced python27-pip

RUN pip install certbot certbot-s3front

COPY fs /

