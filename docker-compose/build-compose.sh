if [ ! -f ./my.env ]; then
    echo "Edit my.env and run me again"
    exit 0
fi

# main
. ./my.env

# lb
export LB_IMAGE=${LB_IMAGE:-kuzzleio/dev}
export LB_VOLUME="[]"
if [ "$LB_PATH" != "" ]; then
    export LB_VOLUME="- \"$(readlink -f ${LB_PATH})/docker-compose/config/pm2-dev.json:/config/pm2.json\"
      - \"$(readlink -f ${LB_PATH}):/var/app\""
fi
export LB_DEBUG="$LB_DEBUG"

# kuzzle
export KUZ_IMAGE=${KUZ_IMAGE:-kuzzleio/dev}
export KUZ_VOLUME=""
if [ "$KUZ_PATH" != "" ]; then
    export KUZ_VOLUME="- \"$(readlink -f ${KUZ_PATH}):/var/app\""
fi
export KUZ_LB_VOLUME="- \"$(readlink -f ${LB_PATH}):/var/kuzzle-load-balancer\""
export KUZ_DEBUG="${KUZ_DEBUG}"

envsubst < docker-compose.yml.tpl > docker-compose.yml
