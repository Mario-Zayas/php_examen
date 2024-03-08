FROM python:3
RUN apt-get update && \
    apt-get install -y python3 python3-pip
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore php mysqlclient
COPY src /var/www/html/
COPY src/database.sql /opt/
ENV DB_USER mario
ENV DB_PASSWORD hola
ENV DB_NAME examen
ENV DB_HOST mariadb_examen
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
EXPOSE 80
CMD /usr/local/bin/script.sh
