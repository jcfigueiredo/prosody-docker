FROM ubuntu:trusty

ENV DEBIAN_FRONTEND  noninteractive
ENV PATH             /build/:$PATH
ENV LANGUAGE         en_US.UTF-8
ENV LANG             en_US.UTF-8
ENV LC_ALL           en_US.UTF-8

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

## This also serves as the list of packages needed to build
RUN apt-get update \
  && apt-get --yes --no-install-recommends install \
      libidn11 \
      liblua5.1-expat0 \
      libssl1.0.0 \
      lua-bitop \
      lua-dbi-mysql \
      lua-dbi-postgresql \
      lua-dbi-sqlite3 \
      lua-event \
      lua-expat \
      lua-filesystem \
      lua-sec \
      lua-socket \
      lua-zlib \
      lua5.1 \
      openssl \
      luarocks \
      prosody \
  && rm -rf /var/lib/apt/lists/*

# COPY ./entrypoint.sh /entrypoint.sh
# RUN chmod 755 /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443 5222 5269 5347 5280 5281
USER prosody
ENV __FLUSH_LOG yes
CMD ["prosody"]