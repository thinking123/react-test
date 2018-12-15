FROM node as build
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
#ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json
RUN npm install --silent
#RUN npm install react-scripts -g --silent
COPY . /usr/src/app
RUN npm run build

FROM nginx
COPY --from=build /usr/src/app/build /var/www
COPY web.conf /etc/nginx/conf.d/
EXPOSE 8086 80
CMD ["nginx", "-g", "daemon off;"]
