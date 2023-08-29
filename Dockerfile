FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get -y install lib32gcc-s1 screen xvfb winbind mariadb-server && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV WS_CONTENT=""
ENV GAME_PARAMS=""
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048 && \
	/etc/init.d/mariadb start && \
	mysql -u root -e "CREATE USER IF NOT EXISTS 'steam'@'%' IDENTIFIED BY 'lifyo';FLUSH PRIVILEGES;" && \
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'steam'@'%' IDENTIFIED BY 'lifyo';" && \
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'LiFYO';FLUSH PRIVILEGES;" && \
	echo "\n[mysqld]\ndatadir=/serverdata/serverfiles/.database/" >> /etc/alternatives/my.cnf

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]