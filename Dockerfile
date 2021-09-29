FROM elixir:1.12.0-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python3 libstdc++

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
COPY assets/package.json assets/package-lock.json ./assets/

RUN mix do setup, deps.compile

COPY lib lib
COPY assets assets
COPY priv priv
COPY Makefile Makefile

RUN make content
RUN mix do assets.deploy, compile
RUN mix release

# prepare release image
FROM alpine:3.9 AS app

RUN apk add --no-cache openssl ncurses-libs libstdc++

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/school_house ./

ENV HOME=/app

CMD bin/school_house eval "SchoolHouse.Release.generate_sitemap" \
  && bin/school_house eval "SchoolHouse.Release.generate_rss" \
  && bin/school_house start
