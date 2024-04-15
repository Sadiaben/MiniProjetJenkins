#DockerFile Satatic web site
FROM nginx
LABEL maintainer= "Sadia ben touirad"
RUN apt-get update &&\
    apt-get upgarde -y &&\
    apt-get install git -y
RUN rm -rf /usr/share/nginx/html/* &&\
    git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html
CMD nginx -g 'daemon off;'
