FROM nginx:alpine
COPY target/app/index.html /usr/share/nginx/html/
EXPOSE 80
