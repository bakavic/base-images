ARG ALPINE_VERSION="3.7"
FROM alpine:${ALPINE_VERSION}
LABEL maintainer="dev@joeir.net" \
      version="1.0.0" \
      description="A minimal Go base image to build Go applications with."
ENV APK_TO_INSTALL="bash curl git gcc g++ make linux-headers binutils-gold gnupg" \
    APK_TO_REMOVE="bash curl git gcc g++ make linux-headers binutils-gold gnupg" \
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
      /usr/share/man/* \
      /var/cache/apk/*" \
    SYSTEM_BIN_PATH=/usr/local/bin/
WORKDIR /tmp
COPY ./version-info /usr/bin/
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
    && go get -u -v github.com/nsf/gocode \
    && go get -u -v github.com/rogpeppe/gopkgs \
    && go get -u -v github.com/ramya-rao-a/go-outline \
    && go get -u -v github.com/acroca/go-symbols \
    && go get -u -v golang.org/x/tools/cmd/guru \
    && go get -u -v golang.org/x/tools/cmd/gorename \
    && go get -u -v sourcegraph.com/sqs/goreturns \
    && go get -u -v github.com/golang/lint/golint \
    && chmod +x /usr/bin/version-info \
    && apk del ${APK_TO_REMOVE} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && mkdir /app
WORKDIR /app
USER root