FROM ruby:2.7.7

RUN apt-get update && apt-get install -y \
    libvips-dev \
    libvips-tools \
    libpng-dev \
    libwebp-dev \
    libjpeg-dev \
    libheif-dev \
    && rm -rf /var/lib/apt/lists/*

# install a modern bundler version
RUN gem install bundler -v 2.1.4


ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
