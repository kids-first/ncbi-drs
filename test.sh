#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob globstar

if [[ -z ${BRANCH_NAME+x} ]]; then
    BRANCH_NAME=$(git symbolic-ref --short HEAD)
fi

if [[ -z ${GIT_COMMIT+x} ]]; then
    GIT_COMMIT=$RANDOM
fi

if [[ -z ${BUILD_NUMBER+x} ]]; then
    BUILD_NUMBER=$RANDOM
fi

if [[ -z ${HTTPPORT+x} ]]; then
    HTTPPORT=$((BUILD_NUMBER+1024))
fi

NAME="${BRANCH_NAME}_${GIT_COMMIT:0:6}_$RANDOM"
NAME="${NAME,,}" # Docker tags must be lowercase
TEST_NAME="test_$NAME"

cd tests

# Start the DRS server
echo "Running server docker image $NAME, listening on host port $HTTPPORT"
docker run --env "HTTPPORT=$HTTPPORT" --publish $HTTPPORT:80 --detach --name "$NAME" drs
sleep 2
CID=$(docker ps --quiet --filter "name=$NAME")
echo "container is $CID"

# curl -s http://localhost:80/ga4gh/drs/v1/objects/SRR000000 | jq -S '.'

# Building and start running tests in container
echo "Running testing docker image $TEST_NAME"
docker build --tag "$TEST_NAME" .
docker run --env "HTTPPORT=$HTTPPORT" --network host --name "$TEST_NAME" "$TEST_NAME"
RET=$?
echo "testing containter returned $RET"

echo "Killing docker images"
docker kill "$CID"
docker container rm "$CID"

#docker kill "$TEST_NAME" || true
docker image rm -f "$TEST_NAME"

exit $RET
