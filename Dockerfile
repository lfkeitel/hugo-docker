# Build hugo from source
FROM alpine:edge AS build-hugo

LABEL maintainer="Lee Keitel" \
      name="lfkeitel/hugo" \
      version="0.52" \
      vcs-type="git" \
      vcs-url="https://github.com/lfkeitel/hugo-docker"

ENV hugo_version=0.52

RUN apk update \
    && apk add go alpine-sdk git \
    && rm -rf /var/cache/apk/*

ADD https://github.com/gohugoio/hugo/archive/v$hugo_version.tar.gz /hugo.tar.gz

RUN mkdir -p $HOME/gohugoio \
    && cd $HOME/gohugoio \
    && tar -xzf /hugo.tar.gz \
    && mv hugo-${hugo_version} hugo \
    && cd hugo \
    && go build -v -o /hugo

# Build image with hugo to serve
FROM alpine:edge

WORKDIR /site

COPY --from=build-hugo /hugo /usr/sbin/hugo

ENTRYPOINT ["/usr/sbin/hugo"]
