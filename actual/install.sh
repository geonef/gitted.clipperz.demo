# Installer script for sysconf "actual"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

sysconf_require_packages nginx php5-fpm mysql-server

rm -f /etc/nginx/sites-enabled/default

if ps x | grep nginx | grep -vq grep; then
    service nginx restart
else
    service nginx start
fi
