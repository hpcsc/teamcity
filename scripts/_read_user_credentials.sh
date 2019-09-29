#!/bin/bash

if [[ -z ${USERNAME+x} ]]; then
    read -p "=== Gogs username (gogs): " USERNAME
    USERNAME=${USERNAME:-gogs}
fi;

if [[ -z ${PASSWORD+x} ]]; then
    IFS= read -rsp "=== Gogs password (password.123): " PASSWORD
    PASSWORD=${PASSWORD:-password.123}
fi;
