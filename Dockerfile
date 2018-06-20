FROM kuzzleio/kuzzle

LABEL "io.kuzzle.vendor"="Kuzzle"

COPY . /var/app/plugins/available/cluster

ENV NODE_ENV production

RUN  set -x \
  \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential \
    python-dev \
    libzmq3-dev \
  \
  && ln -s /var/app/plugins/available/cluster /var/app/plugins/enabled/ \
  && cd /var/app/plugins/enabled/cluster \
  && npm install --unsafe-perm \
  && cp docker-compose/config/kuzzlerc /etc/ \
  && cd /var/app \
  \
  && apt-get remove --purge --auto-remove -y \
    build-essential \
  \
  && echo done