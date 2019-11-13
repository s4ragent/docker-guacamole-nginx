FROM nginx:1.17
LABEL maintainer="@s4ragent"
RUN apt-get update && apt-get install openssl
RUN mkdir -p /opt/nginx/certs
RUN openssl genrsa -out /opt/nginx/certs/server.key 4096 && \
    openssl req -new -batch -key /opt/nginx/certs/server.key -out /opt/nginx/certs/server.csr && \
    openssl x509 -req -days 3650 -in /opt/nginx/certs/server.csr -signkey /opt/nginx/certs/server.key -out /opt/nginx/certs/server.crt
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
