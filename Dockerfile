####################
# first stage build
####################
FROM ruby:2.6.3-alpine as builder
RUN apk --update add --virtual build-dependencies \
    build-base \
    curl-dev \
    mysql-dev \
    imagemagick \
    nodejs \
    linux-headers
RUN gem install bundler
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
ENV BUNDLE_JOBS=4
RUN bundle install

RUN apk del build-dependencies

####################
# final stage build
####################
FROM ruby:2.6.3-alpine
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo
RUN apk --update add \
    bash \
    nodejs \
    mysql-dev \
    yarn \
    imagemagick \
    tzdata
RUN gem install bundler

WORKDIR /tmp
COPY --from=builder /usr/local/bundle /usr/local/bundle

ENV APP_ROOT /app
# Rails App
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

ADD . $APP_ROOT
ENV RAILS_ENV production

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN rm -f tmp/pids/server.pid

# Expose volumes to frontend
VOLUME /app/public
VOLUME /app/tmp
EXPOSE  3000

CMD ["bundle", "exec", "rails", "s", "puma", "-e", "production"]