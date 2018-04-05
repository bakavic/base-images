ARG ALPINE_VERSION="3.7"
FROM alpine:${ALPINE_VERSION}
LABEL maintainer="dev@joeir.net" \
      version="1.0.0" \
      description="A minimal Go base image to build Go applications with."
ARG GO_VERSION="go1.9.3"
ENV APK_TO_INSTALL="bash curl jq openjdk8-jre-base" \
    APK_TO_REMOVE="bash curl jq" \
    PATHS_TO_REMOVE="\
      /tmp/* \
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/*" \
    SYSTEM_BIN_PATH=/usr/local/bin/
WORKDIR /tmp
COPY ./version-info /usr/bin/
COPY ./start /usr/bin/
USER root
RUN apk add --update --upgrade --no-cache ${APK_TO_INSTALL} \
    && printf "$(curl "https://api.github.com/repos/tomakehurst/wiremock/tags" | jq '.[].name | match("[0-9]+.[0-9]+.[0-9]+") | .string' -r | head -n 1)" > ./.wiremock_version \
    && curl -sSL -o ./wiremock.jar "https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/$(cat ./.wiremock_version)/wiremock-standalone-$(cat ./.wiremock_version).jar" \
    && mkdir -p /app \
    && mkdir -p /app/mappings \
    && mkdir -p /app/__files \
    && cp /tmp/* /app/ \
    && cp /tmp/.* /app/ \
    && apk del ${APK_TO_REMOVE} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && chmod +x /usr/bin/version-info /usr/bin/start
WORKDIR /app
VOLUME ["/app/mappings", "/app/__files"]
EXPOSE 8080
ENTRYPOINT ["start"]