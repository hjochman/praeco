FROM s390x/node:lts-buster AS dependencies

RUN apt-get update
RUN apt-get install -y nginx

RUN mkdir -p /tmp/nginx/praeco
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/www/html
RUN chown www-data:www-data /var/www/html
WORKDIR /tmp/nginx/praeco
COPY package.json .

RUN npm install --loglevel error

############################################# Building Main image ########################################################
FROM s390x/node:lts-buster

RUN apt-get update
RUN apt-get install -y nginx

RUN mkdir -p /tmp/nginx/praeco
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/www/html
RUN chown www-data:www-data /var/www/html

WORKDIR /tmp/nginx/praeco

COPY --from=dependencies /tmp/nginx/praeco/node_modules ./node_modules
COPY . .

RUN npm run build
RUN cp -r dist/* /var/www/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
