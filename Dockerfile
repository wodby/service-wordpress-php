ARG WODBY_BASE_IMAGE
FROM ${WODBY_BASE_IMAGE}

ARG COPY_FROM
COPY --chown=wodby:wodby ${COPY_FROM} /var/www/html

ARG DOCROOT_SUBDIR
ARG WODBY_APP_NAME

RUN make init-wordpress -f /usr/local/bin/actions.mk
