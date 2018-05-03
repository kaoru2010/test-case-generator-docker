FROM ruby:2.2.4-alpine

RUN apk add --update --no-cache --virtual=.build-dependencies build-base
RUN apk add --update --no-cache --virtual=.build-dependencies curl-dev
RUN apk add --update --no-cache --virtual=.build-dependencies linux-headers
RUN apk add --update --no-cache --virtual=.build-dependencies ruby-dev
RUN apk add --update --no-cache bash

ENV LANG C.UTF-8
ENV ROOT_PATH /workspace

WORKDIR /workspace
COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install -j4

ENTRYPOINT [ "bundle", "exec", "test_case_generator" ]

CMD [ "-h" ]
