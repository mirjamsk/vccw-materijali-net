#!/usr/bin/env bash

# run mailcatcher
mailcatcher --http-ip=$(ohai | jq -r .network.interfaces.eth1.routes[0].src)
