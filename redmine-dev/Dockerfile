FROM centos:7


RUN set -x && \
	yum install -y epel-release && \
	yum install -y yum-utils && \
	yum-config-manager --enable epel && \
	yum install -y git tcsh vim-enhanced iproute bind-utils ruby ruby-devel yum install -y libffi-devel gcc make ImageMagick-devel sqlite-devel rubygem-json graphviz-ruby && \
	gem install bundler

EXPOSE 3000


CMD cd /redmine && exec bundle exec rails s -b 0.0.0.0

