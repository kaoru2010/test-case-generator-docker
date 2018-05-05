FROM ruby:2.2.4-alpine

ENV LANG C.UTF-8
ENV ROOT_PATH /workspace

WORKDIR /workspace
COPY Gemfile Gemfile.lock ./

RUN apk add --update --no-cache --virtual=.build-dependencies build-base curl-dev linux-headers ruby-dev && \
    gem install bundler && bundle install --without development test && \
    apk del .build-dependencies

#RUN apk add --update --no-cache bash

ENTRYPOINT [ "bundle", "exec", "test_case_generator" ]

CMD [ "-h" ]
