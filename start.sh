#!/bin/bash
HOSTNAME=`hostname`
_term() {
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM
source /etc/j4j/j4j_mount/j4j_hub/env.sh
source /etc/j4j/j4j_mount/j4j_hub/configurable-http-proxy.secret
while :; do if ping -c 1 -W 1 j4j_proxy; then break; else sleep 5; fi; done
while :; do if ping -c 1 -W 1 j4j_postgres; then break; else sleep 5; fi; done
#curl -X "POST" -d{"target":"j4j_integration_hub"} -H "Authorization: token 5d51b171ba0480e2aa21987e0c1f9ec9f472a624229b00580cc716023b055d96" http://j4j_integration_proxy:8001/api/routes/hub/oauth_login_workshop
jupyterhub -f /etc/j4j/j4j_mount/j4j_hub/jupyterhub_config.py >> /etc/j4j/j4j_mount/j4j_hub/logs/${HOSTNAME}.log 2>&1 &
child=$!
wait "$child"
