FROM debian
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php mariadb>
COPY src /var/www/html/
COPY src/database.sql /opt/
RUN rm /var/www/html/index.html
ENV DB_USER mario
ENV DB_PASSWORD hola
ENV DB_NAME examen
ENV DB_HOST mariadb_examen
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
EXPOSE 80
CMD /usr/local/bin/script.sh
