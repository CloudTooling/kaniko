FROM gcr.io/kaniko-project/executor:v1.19.0-debug

ARG BUILD_DATE

ENV BUILD_DATE $BUILD_DATE

# backup kaniko for restore later
RUN mkdir -p /opt/kaniko &&\
  # create .docker folder with correct permissions
  mkdir -p /kaniko/.docker && chmod g+w /kaniko/.docker &&\
  # backup original folder
  cp -rp /kaniko/* /opt/kaniko

COPY bin/entrypoint.sh /bin/docker-entrypoint.sh

CMD ["/bin/sh", "/bin/docker-entrypoint.sh"]
