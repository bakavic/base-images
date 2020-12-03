#!/bin/bash
CURR_DIR=$(dirname $0);
IMAGE_URL=$1
IMAGE_TAG=$2;
BUILD_CONTEXT=$3;
BUILD_ARGS=$4;

if [ "${IMAGE_URL}" = "" ]; then
  printf "\n\e[31m\e[1m[!] Specify the namspace to build as the first argument.\e[0m\n";
  exit 1;
fi;

if [ "${IMAGE_TAG}" = "" ]; then
  printf "\n\e[31m\e[1m[!] Specify the image tag to build as the second argument.\e[0m\n";
  exit 1;
fi;

REPOSITORY_URL=${IMAGE_URL}:${IMAGE_TAG};
NEXT_TAG="${REPOSITORY_URL}-next";
if [ "${BUILD_ARGS}" != "" ]; then
  ADDITIONAL_BUILD_ARGS="$(echo "${BUILD_ARGS}" | sed -e $'s|,|\\\n|g' | xargs -I @ echo '--build-arg @')";
else
  ADDITIONAL_BUILD_ARGS="";
fi;

if [ "${BUILD_CONTEXT}" = "" ]; then
  BUILD_CONTEXT="${CURR_DIR}/../${IMAGE_TAG}/Dockerfile";
fi;

docker build \
  ${ADDITIONAL_BUILD_ARGS} \
  --file ${BUILD_CONTEXT}/Dockerfile \
  --tag "${NEXT_TAG}" \
  ${BUILD_CONTEXT};