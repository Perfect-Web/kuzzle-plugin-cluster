#!/bin/sh

set -eu

ELASTIC_HOST=${kuzzle_services__db__host:-elasticsearch}
ELASTIC_PORT=${kuzzle_services__db__port:-9200}

echo "[$(date --rfc-3339 seconds)][cluster] - Waiting for elasticsearch to be available"
while ! curl -f -s -o /dev/null "http://$ELASTIC_HOST:$ELASTIC_PORT"
do
    echo "[$(date --rfc-3339 seconds)][cluster] - Still trying to connect to http://$ELASTIC_HOST:$ELASTIC_PORT"
    sleep 5
done

# create a tmp index just to force the shards to init
curl -XPUT -s -o /dev/null "http://$ELASTIC_HOST:$ELASTIC_PORT/%25___tmp"
echo "[$(date --rfc-3339 seconds)][cluster] - Elasticsearch is up. Waiting for shards to be active (can take a while)"
E=$(curl -s "http://$ELASTIC_HOST:$ELASTIC_PORT/_cluster/health?wait_for_status=yellow&wait_for_active_shards=1&timeout=60s")
curl -XDELETE -s -o /dev/null "http://$ELASTIC_HOST:$ELASTIC_PORT/%25___tmp"

if ! (echo ${E} | grep -E '"status":"(yellow|green)"' > /dev/null); then
    echo "[$(date --rfc-3339 seconds)][cluster] - Could not connect to elasticsearch in time. Aborting..."
    exit 1
fi

echo "[$(date --rfc-3339 seconds)][cluster] - Waiting for the whole cluster to be up and running"

while ! curl -m 1 --silent http://api:7511/api/1.0/_plugin/kuzzle-plugin-cluster/status 2>&1 | grep -e \"nodesCount\":3 > /dev/null
do
    echo "[$(date --rfc-3339 seconds)][cluster] - still waiting for the whole cluster to be up and running"
    sleep 5
done

echo "[$(date --rfc-3339 seconds)][cluster] - The cluster is up. Start the tests."

npm run functionnal-testing
