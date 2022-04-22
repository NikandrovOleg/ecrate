
#########

FROM elixir:1.13.3-slim AS dev

WORKDIR /app/

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl inotify-tools \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home elixir \
  && mkdir -p /mix && chown elixir:elixir -R /mix /app

USER elixir

RUN mix local.hex --force && mix local.rebar --force

ARG MIX_ENV="prod" \
    CREATE_DATABASE="true"
ENV MIX_ENV="${MIX_ENV}" \
    CREATE_DATABASE="${CREATE_DATABASE}" \
    USER="elixir"

COPY --chown=elixir:elixir mix.* ./
RUN if [ "${MIX_ENV}" = "dev" ]; then \
  mix deps.get; else mix deps.get --only "${MIX_ENV}"; fi

COPY --chown=elixir:elixir config/config.exs config/"${MIX_ENV}".exs config/
RUN mix deps.compile

COPY --chown=elixir:elixir /priv/static /public
COPY --chown=elixir:elixir . .

RUN if [ "${MIX_ENV}" != "dev" ]; then \
  ln -s /public /app/priv/static \
    && mix phx.digest && mix release && rm -rf /app/priv/static; fi

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 8000

CMD ["iex", "-S", "mix", "phx.server"]

############

FROM elixir:1.13.3-slim AS prod

WORKDIR /app/

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl postgresql-client \
  && apt-get clean \
  && useradd --create-home elixir \
  && chown elixir:elixir -R /app

USER elixir

ENV USER=elixir

COPY --chown=elixir:elixir --from=dev /public /public
COPY --chown=elixir:elixir --from=dev /mix/_build/prod/rel/ecrate ./
COPY --chown=elixir:elixir bin/docker-entrypoint bin/

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 8000

CMD ["bin/ecrate", "start"]