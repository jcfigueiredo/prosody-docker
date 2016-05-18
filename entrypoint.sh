#!/bin/bash
set -e

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ] ; then
    # sets admin
    cd /usr/lib/prosody/custom-modules/admin_web/ && sh get_deps.sh
    # creates default user
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

if [[ "$1" == "/bin/bash" ]]; then
    exec /bin/bash
    exit 0;
fi

if [[ "$1" != "prosody" ]]; then
    exec prosodyctl $*
    exit 0;
fi


exec "$@"