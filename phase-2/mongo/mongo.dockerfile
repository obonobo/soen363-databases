FROM mongo:latest

RUN mkdir /home/data  \
    && chown mongodb:mongodb /home/data  \
    && chmod 777 /home/data

CMD ["mongod",  "--auth", "--bind_ip_all", "--dbpath", "/home/data"]
