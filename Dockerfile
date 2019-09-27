FROM ruby:2.6.3-alpine as builder
RUN apk --update add --virtual build-dependencies \
    build-base \
    curl-dev \
    mysql-dev \
    linux-headers
RUN gem install bundler
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
ENV BUNDLE_JOBS=4
RUN bundle install
RUN apk del build-dependencies



FROM ruby:2.6.3-alpine
ENV LANG ja_JP.UTF-8
RUN apk --update add \
    bash \
    nodejs \
    mysql-dev \
    tzdata
RUN gem install bundler

WORKDIR /tmp
COPY --from=builder /usr/local/bundle /usr/local/bundle

ENV APP_ROOT /app
# Rails App
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY . $APP_ROOT

# Expose volumes to frontend
VOLUME /app/public
VOLUME /app/tmp
