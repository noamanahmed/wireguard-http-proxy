#!/bin/bash
echo $@

cp /tinyproxy/tinyproxy.conf /tmp/tinyproxy.conf
ip=$(cat /etc/hosts | grep  wireguard | awk '{print $1}')
gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
echo "" >> /tmp/tinyproxy.conf
echo "#Added by start.sh. These will be overwridden " >> /tmp/tinyproxy.conf
echo "Listen $ip" >> /tmp/tinyproxy.conf
echo "Allow $ip" >> /tmp/tinyproxy.conf
echo "Allow $gateway" >> /tmp/tinyproxy.conf
echo "Allow 127.0.0.1" >> /tmp/tinyproxy.conf
if [ -n "$PROXY_BASIC_USERNAME" ] && [ -n "$PROXY_BASIC_PASSWD" ]; then
    echo "BasicAuth environment is configured. Omitting it to tinyproxy.conf."
    echo "BasicAuth $PROXY_BASIC_USERNAME $PROXY_BASIC_PASSWD" >> /tmp/tinyproxy.conf
fi

cat /tmp/tinyproxy.conf
#Run tinyproxy
tinyproxy -c /tmp/tinyproxy.conf
#Run Wireguard normally

unset WG_CONFS
rm -rf /app/activeconfs
# Enumerate interfaces
for wgconf in $(ls /config/wg_confs/*.conf); do
    if grep -q "\[Interface\]" "${wgconf}"; then
        echo "**** Found WG conf ${wgconf}, adding to list ****"
        WG_CONFS+=("${wgconf}")
    else
        echo "**** Found WG conf ${wgconf}, but it doesn't seem to be valid, skipping. ****"
    fi
done

if [[ -z "${WG_CONFS}" ]]; then
    echo "**** No valid tunnel config found. Please create a valid config and restart the container ****"
    ip route del default
    exit 0
fi

unset FAILED
for tunnel in ${WG_CONFS[@]}; do
    echo "**** Activating tunnel ${tunnel} ****"
    if ! wg-quick up "${tunnel}"; then
      FAILED="${tunnel}"
      break
    fi
done

if [[ -z "${FAILED}" ]]; then
    declare -p WG_CONFS > /app/activeconfs
    echo "**** All tunnels are now active ****"
else
    echo "**** Tunnel ${FAILED} failed, will stop all others! ****"
    for tunnel in ${WG_CONFS[@]}; do
        if [[ "${tunnel}" = "${FAILED}" ]]; then
            break
        else
            echo "**** Disabling tunnel ${tunnel} ****"
            wg-quick down "${tunnel}" || :
        fi
    done
    ip route del default
    echo "**** All tunnels are now down. Please fix the tunnel config ${FAILED} and restart the container ****"
fi

sleep infinity
