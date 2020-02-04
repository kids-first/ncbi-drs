#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

if [[ -z ${BRANCH_NAME+x} ]]; then
    BRANCH_NAME=$(git symbolic-ref --short HEAD)
fi

if [[ -z ${GIT_COMMIT+x} ]]; then
    GIT_COMMIT=$RANDOM
fi

PORT=80
NAME="${BRANCH_NAME}_${GIT_COMMIT:0:6}_$RANDOM"
NAME="${NAME,,}" # Docker tags must be lowercase

cd tests

# Start the DRS server
echo "Running docker image $NAME, listening on host port $PORT"
docker run --network host --detach --name "$NAME" drs
sleep 5

CID=$(docker ps --quiet --filter "name=$NAME")
echo "container is $CID"

# curl -s http://localhost:80/ga4gh/drs/v1/objects/SRRTESTTEST | jq -S '.'

# Building and start running tests in container
docker build --tag "tests_$NAME" .
docker run --network host --name "tests_$NAME" "tests_$NAME"
RET=$?
echo "containter returned $RET"

echo "Killing docker images"
docker kill "$CID"
docker container rm "$CID"

exit $RET
