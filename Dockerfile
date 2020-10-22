FROM s390x/node:lts-buster

RUN apt-get update
RUN apt-get install -y nginx

RUN mkdir -p /tmp/nginx/praeco
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/www/html
RUN chown www-data:www-data /var/www/html

WORKDIR /tmp/nginx/praeco

COPY . .

RUN npm install --loglevel error
RUN npm run build
RUN cp -r dist/* /var/www/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
