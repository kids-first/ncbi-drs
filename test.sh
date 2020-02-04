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
TEST_NAME="test_$NAME"

cd tests

# Start the DRS server
echo "Running server docker image $NAME, listening on host port $PORT"
docker run --network host --detach --name "$NAME" drs
sleep 2
CID=$(docker ps --quiet --filter "name=$NAME")
echo "container is $CID"

# curl -s http://localhost:80/ga4gh/drs/v1/objects/SRRTESTTEST | jq -S '.'

# Building and start running tests in container
echo "Running testing docker image $TEST_NAME"
docker build --tag "$TEST_NAME" .
docker run --network host --name "$TEST_NAME" "$TEST_NAME"
RET=$?
echo "testing containter returned $RET"

echo "Killing docker images"
docker kill "$CID"
docker container rm "$CID"

docker kill "$TEST_NAME"
docker image rm -f "$TEST_NAME"

exit $RET
