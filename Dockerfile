##############
#First Stage
##############
FROM ruby:2.6.3-alpine as builder
RUN apk --update add --virtual build-dependencies \
    build-base \
    curl-dev \
    mysql-dev \
    nodejs \
    yarn \
    linux-headers
RUN gem install --no-document bundler
RUN bundle install -j4 --retry 3 \
      && rm -rf /usr/local/bundle/cache/*.gem \
      && find /usr/local/bundle/gems/ -name "*.c" -delete \
      && find /usr/local/bundle/gems/ -name "*.o" -delete
RUN apk del build-dependencies
# Install yarn packages
COPY package.json yarn.lock /app/
RUN yarn install
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Add the Rails app
ADD . /app

################
#Final Stage
################
FROM ruby:2.6.3-alpine
ENV LANG ja_JP.UTF-8
RUN apk add --update --no-cache \
    bash \
    mysql-dev \
    tzdata

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app

ENV APP_ROOT /app
WORKDIR $APP_ROOT

# Expose volumes to frontend
VOLUME /app/public
VOLUME /app/tmp

EXPOSE  3000


# Start Puma
ENV RAILS_ENV production
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY
CMD ["bundle", "exec", "rails", "s", "puma", "-e", "production"]