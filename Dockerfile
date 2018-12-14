FROM nginx
MAINTAINER TKing
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    sudo apt-get install -y nodejs
VOLUME . /app
WORKDIR /app
RUN npm install && npm run build
COPY ./build  /var/www/
COPY web.conf /etc/nginx/conf.d/default.conf
CMD npm build
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]