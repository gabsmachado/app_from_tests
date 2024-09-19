FROM ruby:3.3.5-slim

LABEL Name=rapidoocore Version=0.0.1

ENV INSTALL_PATH /home/app
ENV BUNDLER_VERSION=2.5
ENV NODE_MAJOR_VERSION=16

# Installing system dependencies
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  gnupg2 \
  iproute2 \
  less \
  libpq-dev \
  libxml2-dev \
  tzdata

# Installing node and yarn
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  nodejs \
  yarn

# Cleaning installation
RUN apt-get clean && \
  apt autoremove -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Installing bundler
RUN gem update --system && \
  gem install bundler -v $BUNDLER_VERSION

# Copying project's source
COPY . $INSTALL_PATH

# Installing project's dependencies
WORKDIR $INSTALL_PATH
RUN bundle install
RUN bundle install --gemfile=.overcommit_gems.rb
RUN bundle exec bootsnap precompile --gemfile app/ lib/
RUN yarn install

# Exposing port 3000
EXPOSE 3000

# Starts the development server, accessible through https://localhost:3000
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
