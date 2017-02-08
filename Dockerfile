# vim:set ft=dockerfile:
FROM alpine:latest

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# maybe we want also add:
# ruby-rdoc ruby-io-console ruby-irb
RUN apk add --update \
      ruby ruby-bigdecimal ruby-bundler \
      build-base ruby-dev; \
apk add --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/main/ \
     ca-certificates libressl libressl-dev; \
\
bundle config build.nokogiri --use-system-libraries; \
bundle config git.allow_insecure true; \
\
gem install json foreman --no-rdoc --no-ri; \
gem cleanup; \
rm -rf /usr/lib/ruby/gems/*/cache/*; \
apk del libressl-dev build-base ruby-dev; \
rm -rf /var/cache/apk/* /tmp;
