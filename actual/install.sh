# Installer script for sysconf "actual"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

# A few settings
GITTED_CLIPPERZ_ROOT_DIR=/var/lib/clipperz
GITTED_CLIPPERZ_UPSTREAM_URL=https://github.com/clipperz/password-manager.git
GITTED_CLIPPERZ_UPSTREAM_REF=release.2014.06.21

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
echo "CREATE DATABASE IF NOT EXISTS clipperz " | mysql
echo "CREATE USER 'clipperz' IDENTIFIED BY 'clipperz'" | mysql
echo "GRANT ALL PRIVILEGES ON clipperz . * TO 'clipperz' " | mysql

# Build ClipperZ out of upstream repository
if [ ! -d $GITTED_CLIPPERZ_ROOT_DIR ]; then
    git clone -b $GITTED_CLIPPERZ_UPSTREAM_REF \
        $GITTED_CLIPPERZ_UPSTREAM_URL $GITTED_CLIPPERZ_ROOT_DIR \
        || nef_fatal "Failed to fetch ClipperZ reference '$GITTED_CLIPPERZ_UPSTREAM_REF' form URL: $GITTED_CLIPPERZ_UPSTREAM_URL"
    cd $GITTED_CLIPPERZ_ROOT_DIR
    ./scripts/build install --backends php python --frontends beta gamma \
        || nef_fatal "Failed to build ClipperZ"
fi
