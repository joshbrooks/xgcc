#! /bin/bash

docker build -t josh/xgcc .
docker create -v /var/log/koha/library -v /var/lib/koha/library -v /etc/koha/sites/library -v /etc/apache2/sites-available --name xgcc_data josh/xgcc

docker build -t josh/mariadb:koha mariadb_koha
docker create -v /var/lib/mysql --name koha_db josh/mariadb:koha


