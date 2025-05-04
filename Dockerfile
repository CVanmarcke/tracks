ARG RUBY_VERSION=3.3
FROM ruby:${RUBY_VERSION} AS base

WORKDIR /app
RUN touch /etc/app-env && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn netcat-openbsd && \
    gem install bundler && \
    mkdir /app/log

COPY COPYING /app/
COPY config /app/config/
COPY config/database.sqlite.yml /app/config/database.yml
COPY config/site.docker.yml /app/config/site.yml

COPY bin /app/bin/
COPY script /app/script/
COPY public /app/public/
COPY vendor /app/vendor/

COPY .yardopts Rakefile config.ru docker-entrypoint.sh /app/

COPY lib /app/lib/
COPY app /app/app/
COPY db /app/db/

# Use glob to omit error if the .git directory doesn't exists (in case the
# code is from a release archive, not a Git clone)
COPY .gi[t] /app/.git

COPY Gemfile* /app/

ENTRYPOINT ["/app/docker-entrypoint.sh"]
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]

FROM base AS precompile
RUN bundle config set deployment true && \
    bundle install --jobs 4 && \
    RAILS_GROUPS=assets bundle exec rake assets:precompile

# Build the environment-specific stuff
FROM base AS production
RUN bundle config set without assets && \
    bundle config --global frozen 1 && \
    bundle install --jobs 4
COPY --from=precompile /app/public/assets /app/public/assets

FROM base AS test
COPY test /app/test/
# For testing the API client
COPY doc /app/doc/
RUN bundle config set without assets
RUN bundle config set with development test
RUN bundle config --global frozen 1
RUN bundle install --jobs 4
COPY --from=precompile /app/public/assets /app/public/assets

FROM base AS development
RUN bundle config set with development test
RUN bundle install --jobs 4
