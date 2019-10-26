FROM alpine:3.10
LABEL maintainer="antony"

ENV NGINX_VERSION=1.10.1
RUN yum update -y \

  && yum install -y gcc pcre-devel zlib-devel make \

  && curl -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \

  && tar -C /tmp -xzf nginx-${NGINX_VERSION}.tar.gz \
  && rm nginx-${NGINX_VERSION}.tar.gz \
	
  && cd /tmp/nginx-${NGINX_VERSION} \
	
  && ./configure \
	
  && make \
	
  && make install \
	
  && chmod -R g+w /usr/local/nginx \
	
  && sed -i 's/ 80;/ 8080;/g' /usr/local/nginx/conf/nginx.conf \
	
  && yum clean -y all
	
# expose nginx port
	
EXPOSE 8080
	
# run nginx in no-daemon mode
	
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
