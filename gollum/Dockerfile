FROM ruby:2.7-alpine AS builder

#RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
#RUN apk update

#RUN echo http://mirrors.aliyun.com/alpine/v3.15/main/ > /etc/apk/repositories && \
#    echo http://mirrors.aliyun.com/alpine/v3.15/community/ >> /etc/apk/repositories
#RUN apk update

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
#RUN sed -i 's/https/http/' /etc/apk/repositories
#RUN echo -e "http://nl.alpinelinux.org/alpine/v3.15/main\nhttp://nl.alpinelinux.org/alpine/v3.15/community" > /etc/apk/repositories
#RUN apk update
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk --no-cache --no-progress add \
    build-base \
    cmake \
    git \
    icu-dev \
    openssl-dev

RUN gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ --remove https://rubygems.org/
RUN bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems

COPY Gemfile* /tmp/
COPY gollum.gemspec* /tmp/
WORKDIR /tmp
RUN bundle install

#RUN gem install \
#    asciidoctor \
#    creole \
#    wikicloth \
#    org-ruby \
#    RedCloth \
#    bibtex-ruby \
#    --no-document \
#    && echo "gem-extra complete"

WORKDIR /app
COPY . /app
RUN bundle exec rake install

RUN gem install --local --no-document gollum-auth-0.7.1.gem
# RUN gem update

FROM ruby:2.7-alpine

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
#RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

#RUN echo https://mirrors.aliyun.com/alpine/v3.15/main/ > /etc/apk/repositories && \
#    echo https://mirrors.aliyun.com/alpine/v3.15/community/ >> /etc/apk/repositories && \
#    apk update 

#RUN sed -i 's/https/http/' /etc/apk/repositories
#RUN echo -e "http://nl.alpinelinux.org/alpine/v3.15/main\nhttp://nl.alpinelinux.org/alpine/v3.15/community" > /etc/apk/repositories
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk --no-cache --no-progress add \
    bash \
    git \
    libc6-compat \
	tzdata

ENV TZ=Asia/Shanghai

VOLUME /wiki
WORKDIR /wiki

COPY docker-run.sh /

ENTRYPOINT ["/docker-run.sh"]
