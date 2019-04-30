#!/bin/sh
set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

MYSQL_ADDR=${MYSQL_ADDR:-"db"}
MYSQL_USER=${MYSQL_USER:-"root"}
MYSQL_ROOT_PASS=${MYSQL_ROOT_PASS:-"123456"}
CA_DB_NAME=${CA_DB_NAME:-"collectiveaccess"}
CA_DB_USER=${CA_DB_USER:-"root"}
CA_DB_PASS=${CA_DB_PASS:-"123456"}


changesetup()
{
	setup_file=/var/www/html/setup.php
	sed -i "s@define(\"__CA_DB_HOST__\", 'localhost');@define(\"__CA_DB_HOST__\", \'$MYSQL_ADDR\');@g" $setup_file
	sed -i "s@define(\"__CA_DB_USER__\", 'my_database_user');@define(\"__CA_DB_USER__\", \'$CA_DB_USER\');@g" $setup_file
	sed -i "s@define(\"__CA_DB_PASSWORD__\", 'my_database_password');@define(\"__CA_DB_PASSWORD__\", \'$CA_DB_PASS\');@g" $setup_file
	sed -i "s@define(\"__CA_DB_DATABASE__\", 'name_of_my_database');@define(\"__CA_DB_DATABASE__\", \'$CA_DB_NAME\');@g" $setup_file
}

changesetup

if [ "${1:0:1}" = "-" ] ; then
	exec /usr/sbin/httpd "$@"
fi

if [ "$1" = "/usr/sbin/httpd" ] ; then
	exec "$@"
fi

if [ "$1" = "apache2" ] ; then
	exec /usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
fi

exec "$@"


# vim: tw=200
