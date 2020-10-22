FROM  s390x/ubi8:nodejs-10

RUN yum update
RUN yum install -y nginx

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
