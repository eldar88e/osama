# =========================
# Builder
# =========================
FROM ruby:3.4.8-alpine3.23 AS builder

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    vips-dev \
    yaml-dev \
    tzdata
#    yarn
#    ruby-dev
#    libc6-compat

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test"

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v "$(tail -n 1 Gemfile.lock)" \
 && bundle install --jobs=4 --retry=3 \
 && bundle clean --force \
 && rm -rf /usr/local/bundle/cache

# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile --production

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/ config/
# RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

# =========================
# Runtime layer
# =========================
FROM ruby:3.4.8-alpine3.23 AS runtime

RUN apk add --no-cache \
    tzdata \
    libpq \
    yaml \
    vips
#    jemalloc \
#    ca-certificates

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test"
#    LD_PRELOAD=/usr/lib/libjemalloc.so.2

WORKDIR /app

RUN addgroup -g 1000 deploy && adduser -u 1000 -G deploy -D -s /bin/sh deploy
# && chown -R deploy:deploy /app /usr/local/bundle \

COPY --chown=deploy:deploy --from=builder /app /app
# COPY --chown=deploy:deploy --from=builder /usr/local/bundle /usr/local/bundle

USER deploy:deploy

EXPOSE 3000
