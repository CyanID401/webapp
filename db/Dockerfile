FROM mysql:9.1.0

USER mysql

COPY ./*.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]