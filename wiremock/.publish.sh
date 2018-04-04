#!/bin/sh
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_WIREMOCK=$(printf "${VERSIONS}" | grep -e 'wiremock:' | cut -f 2 -d ':');
EXISTENCE_TAG="wiremock-${VERSION_WIREMOCK}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
WIREMOCK_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_WIREMOCK}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
$(docker pull ${EXISTENCE_REPO_URL}) && EXISTS=$?;
if [ "${EXISTS}" != "0" ] || [ -z "${COMMIT_MESSAGE##*'[force build]'*}" ]; then
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${WIREMOCK_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${WIREMOCK_VERSION_REPO_URL};
  docker push ${WIREMOCK_VERSION_REPO_URL};
else
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
fi;