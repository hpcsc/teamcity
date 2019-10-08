#!/bin/bash

# Usage:
# ./scripts/generate-token.sh
# ./scripts/generate-token.sh token-name

set -e

source ./scripts/_read_user_credentials.sh

echo

ACCESS_KEY_NAME=${1:-default-access-key}

EXISTING_KEY=$(curl -s http://${USERNAME}:${PASSWORD}@localhost:3000/api/v1/users/${USERNAME}/tokens | \
        jq -r '.[] | select(.name == "'${ACCESS_KEY_NAME}'")')

if [[ -z "${EXISTING_KEY}" ]]; then
    curl --silent \
         --output /dev/null \
         --show-error \
         -X POST \
         -H "Content-Type: application/json" \
         -d '{"name":"'${ACCESS_KEY_NAME}'"}' \
         http://${USERNAME}:${PASSWORD}@localhost:3000/api/v1/users/gogs/tokens
fi;

curl -s http://${USERNAME}:${PASSWORD}@localhost:3000/api/v1/users/${USERNAME}/tokens | \
        jq -r '.[] | select(.name == "'${ACCESS_KEY_NAME}'") | .sha1'
