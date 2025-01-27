#!/bin/sh
set -e

gtn_host="${GTN_HOST:-gluetun}"
gtn_port="${GTN_PORT:-8000}"
qbt_port="${QBT_ADDR:-8080}"

gtn_addr="http://${gtn_host}:${gtn_port}"
qbt_addr="http://${gtn_host}:${qbt_port}"

port_number=$(curl --fail --silent --show-error  $gtn_addr/v1/openvpn/portforwarded | jq '.port')
if [ ! "$port_number" ] || [ "$port_number" = "0" ]; then
    echo "Could not get current forwarded port from gluetun, exiting..."
    exit 1
fi

listen_port=$(curl --fail --silent --show-error $qbt_addr/api/v2/app/preferences | jq '.listen_port')

if [ ! "$listen_port" ]; then
    echo "Could not get current listen port, exiting..."
    exit 1
fi

if [ "$port_number" = "$listen_port" ]; then
    echo "Port already set, exiting..."
    exit 0
fi

echo "Updating port to $port_number"

curl --fail --silent --show-error --data-urlencode "json={\"listen_port\": $port_number}"  $qbt_addr/api/v2/app/setPreferences

echo "Successfully updated port"
