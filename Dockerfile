FROM nginx
LABEL maintainer="Sadia ben touirad"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get install -y git
RUN rm -Rf /usr/share/nginx/html/* &&\
    git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD  nginx -g 'daemon off;'
