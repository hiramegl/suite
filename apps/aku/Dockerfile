# image to build the relase files
FROM elixir:1.18.3-alpine AS build
RUN apk upgrade --no-cache && apk add --no-cache git
COPY . .
RUN export MIX_ENV=dev && rm -Rf _build && cd apps/APP_NAME && mix setup && mix release

# the image that will be actually running
FROM alpine:3.21.3 AS final
RUN apk upgrade --no-cache && apk add --no-cache openssl libgcc libstdc++ ncurses-libs git inotify-tools
EXPOSE <PORT_NUMBER>
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
#ENV USER="elixir"
#WORKDIR "/home/${USER}/app"
#RUN addgroup -g 1000 -S "${USER}" && adduser -s /bin/sh -u 1000 -G "${USER}" -h "/home/${USER}" -D "${USER}" && su "${USER}"
#USER "${USER}"
#COPY --from=build --chown="${USER}":"${USER}" /_build/dev/rel/APP_NAME ./
WORKDIR "/home/app"
COPY --from=build /apps/APP_NAME/_build/dev/rel/APP_NAME ./
ENTRYPOINT ["bin/APP_NAME"]
CMD ["start"]
