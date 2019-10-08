#!/bin/bash

KEY_NAME=${1:-default-key}
KEY_LOCATION=${2:-~/.ssh/id_rsa.pub}

source ./scripts/_read_user_credentials.sh

echo

TOKEN=$(source ./scripts/generate-token.sh "" | tr -d "\n")

EXISTING_KEY=$(curl -s http://localhost:3000/api/v1/users/${USERNAME}/keys \
     -H 'Content-Type:application/json' \
     -H "Authorization: token ${TOKEN}" | \
     jq -r '.[] | select (.title == "'${KEY_NAME}'")')

if [[ -z "${EXISTING_KEY}" ]]; then
    curl \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: token ${TOKEN}" \
        -d "{ \"title\": \"${KEY_NAME}\", \"key\": \"$(cat ${KEY_LOCATION})\" }" \
        http://localhost:3000/api/v1/user/keys
else
    echo "=== Key ${KEY_NAME} is uploaded before"
fi;

