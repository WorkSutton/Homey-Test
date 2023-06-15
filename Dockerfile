FROM ruby:3.2.2-alpine3.18

LABEL maintainer="work.sutton.notifications@gmail.com"

RUN apk update && apk add --virtual build-dependencies \
  build-base \
  git \
  nodejs \
  tzdata \
  postgresql-dev \
  postgresql-client \
  libxslt-dev \
  libxml2-dev \
  imagemagick \
  vim \
  yarn

RUN gem update --system && gem install bundler
COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app
ENV BUNDLE_PATH /gems
RUN bundle install -j $(nproc --ignore=1) 

COPY . /usr/src/app
RUN yarn install

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
