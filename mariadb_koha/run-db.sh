#!/bin/bash
set -e
set -x
echo "Running database" 
# first, if the /var/lib/mysql directory is empty, unpack it from our predefined db
[ "$(ls -A /var/lib/mysql)" ] && echo "Running with existing database in /var/lib/mysql" || ( echo 'Populate initial db'; tar xpzvf default_mysql.tar.gz )

mysqld_safe