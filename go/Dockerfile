ARG ALPINE_VERSION="3.7"
FROM alpine:${ALPINE_VERSION}
LABEL maintainer="dev@joeir.net" \
      version="1.0.0" \
      description="A minimal Go base image to work with."
ENV APK_TO_INSTALL="bash curl git gcc make linux-headers binutils-gold gnupg" \
    APK_TO_REMOVE="bash curl git gcc make binutils-gold gnupg" \
    GO_REPO_URL="https://go.googlesource.com/go" \
    GO_VERSION="go1.9.3" \
    GO_VERSION_LAST_C_TOOLCHAIN="go1.4" \
    GOROOT_BOOTSTRAP="/tmp/go1.4" \
    PATHS_TO_REMOVE="\
      ${INSTALL_PATH}/* \
      /root/.gnupg/* \
      /root/.node-gyp/* \
      /root/.npm/* \
      /usr/include/* \
      /usr/lib/node_modules/npm/man/* \
      /usr/lib/node_modules/npm/doc/* \
      /usr/lib/node_modules/npm/html/* \
      /usr/lib/node_modules/npm/scripts/* \
      /usr/share/man/* \
      /var/cache/apk/*" \
    SYSTEM_BIN_PATH=/usr/local/bin/
WORKDIR /tmp
RUN apk add --update --upgrade --no-cache ${APK_TO_INSTALL} \
    && git clone ${GO_REPO_URL} \
    && cp -r go go1.4 \
    && cd /tmp/go1.4/src \
    && git checkout release-branch.${GO_VERSION_LAST_C_TOOLCHAIN} \
    && ./make.bash \
    && cd /tmp/go/src \
    && git checkout ${GO_VERSION} \
    && ./make.bash \
    && mv /tmp/go /usr/lib/go \
    && ln -s /usr/lib/go/bin/go ${SYSTEM_BIN_PATH} \
    && ln -s /usr/lib/go/bin/gofmt ${SYSTEM_BIN_PATH} \
    && chmod +x /usr/bin/version-info \
    && apk del ${APK_TO_REMOVE} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && mkdir /app
WORKDIR /app
USER root