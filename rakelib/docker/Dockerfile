# -*- mode: dockerfile -*-
FROM delitescere/jdk:8

RUN apk add --no-cache --virtual=.build-dependencies curl coreutils && \
    apk add --no-cache --virtual=.run-dependencies bash ca-certificates

ENV BIN_PATH /usr/local/bin
RUN mkdir -p $BIN_PATH

ENV LEIN_ROOT true
ENV LEIN_DOWNLOAD_SHA 0de3d0ea19b3d952dcad35ce5e1c6b6dfe153da53d82b070b140a3a7e79e9c3e24e1344c7bda89969bf9a5fb52c70611fd00ab4b9498e3453318336fb94d201a
ENV LEIN_URI https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein

RUN set -eux -o pipefail                          && \
    cd $BIN_PATH                                  && \
    curl -fLsS $LEIN_URI > lein                   && \
    echo $LEIN_DOWNLOAD_SHA lein | sha512sum -c - && \
    chmod a+x lein                                && \
    apk del .build-dependencies                   && \
    rm -f APKINDEX.*                              && \
    rm -rf /tmp/* /var/cache/apk/*

ENV M2_REPO /usr/local/lib/m2
RUN mkdir -p $M2_REPO

RUN touch ~/.m2 && chmod 0400 ~/.m2 # NO user maven-repo
RUN mkdir -p /etc/leiningen/ && \
    echo "{:system { :local-repo \"${M2_REPO}\" }}" > /etc/leiningen/profiles.clj
RUN echo '(exit)' | lein repl

COPY ./docker/build/docker-entrypoint.sh $BIN_PATH/
COPY ./docker/build/is_ready ./docker/build/test $BIN_PATH/

ONBUILD ARG APP_HOME=/usr/src/app
ONBUILD RUN mkdir -p     $APP_HOME
ONBUILD WORKDIR          $APP_HOME
ONBUILD COPY project.clj $APP_HOME/
ONBUILD RUN echo '(exit)' | \
  lein \
    update-in :repl-options assoc :init-ns clojure.core -- \
    repl

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["uberjar"]
