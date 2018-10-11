FROM centos:7

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN set -x && \
    chmod +x /tini && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --verify /tini.asc
ENTRYPOINT ["/tini", "--"]


RUN set -x && \
	yum install -y epel-release yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y which git gcc gcc-c++ make python34-pip python34-devel && \
	pip3 install --upgrade pip

COPY requirements.txt /
RUN AIRFLOW_GPL_UNIDECODE=1 pip3 install -r requirements.txt

EXPOSE 8080
ENV AIRFLOW_HOME=/airflow

COPY fs /

CMD ["/bootstrap.sh"]

