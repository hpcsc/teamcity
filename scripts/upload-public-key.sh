#!/bin/bash

KEY_NAME=${1:-default-key}

source ./scripts/_read_user_credentials.sh

echo

TOKEN=$(source ./scripts/generate-token.sh | tr -d "\n")

EXISTING_KEY=$(curl -s http://localhost:3000/api/v1/users/${USERNAME}/keys \
     -H 'Content-Type:application/json' \
     -H "Authorization: token ${TOKEN}" | \
     jq -r '.[] | select (.title == "'${KEY_NAME}'")')

if [[ -z "${EXISTING_KEY}" ]]; then
    curl \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: token ${TOKEN}" \
        -d "{ \"title\": \"${KEY_NAME}\", \"key\": \"$(cat ~/.ssh/id_rsa.pub)\" }" \
        http://localhost:3000/api/v1/user/keys
else
    echo "=== Key ${KEY_NAME} is uploaded before"
fi;

