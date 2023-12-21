FROM ruby:2.7.7

ARG REFRESHED_AT
ENV REFRESHED_AT $REFRESHED_AT

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -\
    && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    libvips-dev \
    libvips-tools \
    libpng-dev \
    libwebp-dev \
    libjpeg-dev \
    libheif-dev \
    && apt-get upgrade -qq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g yarn@1

# install a modern bundler version
RUN gem install bundler


ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
