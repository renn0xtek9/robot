#!/bin/bash
set -euxo pipefail

sudo curl -v --cert /etc/apt/certs/client.crt\
    --key  /etc/apt/certs/client.key\
    -O https://192.168.178.39/repo-public.asc

sudo gpg --dearmor \
    -o /usr/share/keyrings/charlieindia.gpg \
    repo-public.asc

sudo tee /etc/apt/sources.list.d/charlieindia.list >/dev/null <<EOF
deb [signed-by=/usr/share/keyrings/charlieindia.gpg] \
https://192.168.178.39 stable main
EOF

sudo apt-get update 
