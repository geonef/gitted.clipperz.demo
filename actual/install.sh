# Installer script for sysconf "actual"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

# A few settings
GITTED_CLIPPERZ_ROOT_DIR=/var/lib/clipperz
GITTED_CLIPPERZ_UPSTREAM_URL=https://github.com/clipperz/password-manager.git
GITTED_CLIPPERZ_UPSTREAM_REF=release.2014.06.21

echo TEST___________

mysql_run() {
    echo "MySQL query: $1" >&2
    echo "$1" >&2
    echo "$1" | mysql
    local _status=${PIPESTATUS[1]}
    if [ $_status -ne 0 ]; then
        nef_fatal "MySQL query failed with status $_status"
    fi
}

# Install required Debian packages
_packages=
_packages="$_packages nginx mysql-server"
_packages="$_packages php5-fpm"                 # for PHP back-end
_packages="$_packages python"                   # for Python back-end
_packages="$_packages python-git"               # for build scripts

sysconf_require_packages $_packages
rm -f /etc/nginx/sites-enabled/default /etc/php5/fpm/pool.d/www.conf
if ps x | grep nginx | grep -vq grep; then
    service nginx restart
else
    service nginx start
fi

# Create MySQL database and user for ClipperZ
mysql_run "CREATE DATABASE IF NOT EXISTS clipperz"
_count=$(mysql_run "SELECT User FROM mysql.user WHERE User = 'clipperz'" | grep ^clipperz | wc -l)
if [ $_count -eq 0 ]; then
    mysql_run "CREATE USER 'clipperz' IDENTIFIED BY 'clipperz'"
    mysql_run "GRANT ALL PRIVILEGES ON clipperz.\* TO 'clipperz' "
    mysql_run "FLUSH PRIVILEGES"
fi

# Build ClipperZ out of upstream repository
if [ ! -d $GITTED_CLIPPERZ_ROOT_DIR ]; then
    git clone -b $GITTED_CLIPPERZ_UPSTREAM_REF \
        $GITTED_CLIPPERZ_UPSTREAM_URL $GITTED_CLIPPERZ_ROOT_DIR \
        || nef_fatal "Failed to fetch ClipperZ reference '$GITTED_CLIPPERZ_UPSTREAM_REF' form URL: $GITTED_CLIPPERZ_UPSTREAM_URL"
    cd $GITTED_CLIPPERZ_ROOT_DIR
    ./scripts/build install --backends php python --frontends beta gamma \
        || nef_fatal "Failed to build ClipperZ"
fi
