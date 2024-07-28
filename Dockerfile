# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.0.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

ENV RAILS_ENV="production" \
  BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development"

FROM base as build

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev git libvips pkg-config

COPY Gemfile Gemfile.lock ./
COPY Gemfile Gemfile.lock ./
RUN BUNDLE_DEPLOYMENT="0" bundle install && \
  rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

FROM base

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y curl default-mysql-client libvips && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Entrypoint script
COPY bin/docker-entrypoint /usr/local/bin/docker-entrypoint

# Run as root to set permissions
USER root

RUN useradd rails --create-home --shell /bin/bash && \
  mkdir -p /rails/db /rails/log /rails/storage /rails/tmp && \
  chown -R rails:rails /rails/db /rails/log /rails/storage /rails/tmp && \
  chmod -R 777 /rails

# Add rails command to the PATH
RUN ln -s /usr/local/bundle/bin/rails /usr/local/bin/rails

# Add bin directory to the PATH
ENV PATH="/rails/bin:${PATH}"

USER rails:rails

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
