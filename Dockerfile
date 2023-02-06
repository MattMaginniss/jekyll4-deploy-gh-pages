FROM ruby:2.7.7

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -\
    apt-get update && apt-get install -qq --no-install-recommends \
    nodejs \
    libvips-dev \
    libvips-tools \
    libpng-dev \
    libwebp-dev \
    libjpeg-dev \
    libheif-dev \
    && rm -rf /var/lib/apt/lists/*

# install a modern bundler version
RUN gem install bundler

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
