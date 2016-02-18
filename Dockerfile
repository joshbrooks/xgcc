FROM josh/koha:latest

MAINTAINER Joshua Brooks "josh.vdbroek@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

COPY mysql-koha-common.cnf /etc/mysql/koha-common.cnf

COPY koha.cron etc/cron.d/koha

RUN sudo ln -s /usr/share/koha/bin/koha-zebra-ctl.sh \
        /etc/init.d/koha-zebra-daemon && \
    	sudo update-rc.d koha-zebra-daemon defaults && \
    	sudo service koha-zebra-daemon start

RUN sudo a2enmod rewrite && \
    sudo a2enmod deflate && \
    sudo service apache2 restart

RUN a2dissite 000-default


COPY library/library.sql.gz /
COPY library/library.tar.gz /

RUN echo ''
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
RUN echo "Listen 8080" >> /etc/apache2/ports.conf

EXPOSE 80 8080
# ENTRYPOINT ["./entrypoint.sh"]
CMD ["./entrypoint.sh"]
