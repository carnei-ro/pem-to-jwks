FROM ruby:2.7

RUN gem install chilkat optparse

COPY ./certificate-to-jwks /certificate-to-jwks

ENTRYPOINT [ "ruby", "/certificate-to-jwks" ]
