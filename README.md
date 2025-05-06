# Suite

Starting nginx and all containers

    docker-compose up --build

Once everything is build an running you can access the
assembled product page via
[http://127.0.0.1:3000/](http://127.0.0.1:3000/).

### Fix deps/phoenix_live_reload/lib/phoenix_live_reload/live_reload.ex:
* line 126: url = config[:url] || endpoint.path("/portal_int/phoenix/live_reload/socket#{suffix(endpoint)}")
* line 184: path = conn.private.phoenix_endpoint.path("/portal_int/phoenix/live_reload/frame#{suffix(endpoint)}")
<hr/>

* Log
<hr/>

* mix local.hex
* mix archive.install hex phx_new 1.7.21
<hr/>

* docker volume create pg_data_portal_int
* docker run --name pg-portal-int -v pg_data_portal_int:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6000:5432 postgres:17.4-alpine3.21
* docker volume create pg_data_toggles
* docker run --name pg-toggles -v pg_data_toggles:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6010:5432 postgres:17.4-alpine3.21
* docker volume create pg_data_aku_int
* docker run --name pg-aku-int -v pg_data_aku_int:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6100:5432 postgres:17.4-alpine3.21
<hr/>

* docker volume create pg_data_portal_ext
* docker run --name pg-portal-ext -v pg_data_portal_ext:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 7000:5432 postgres:17.4-alpine3.21
* docker volume create pg_data_aku_ext
* docker run --name pg-aku-ext -v pg_data_aku_ext:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 7100:5432 postgres:17.4-alpine3.21
<hr/>

* mix phx.new portal_int
* manually fix all files in "config/" dir
* mix setup # (deps.get, assets.setup, deps.compile, ecto.create, etc)
* mix phx.server

## Compiling and running inside a docker container
* docker volume create mix_portal_int
* docker run -it --name portal_int -v mix_portal_int:/root/.mix --volume=".":/suite:rw -w /suite -p 4000:4000/tcp -e MIX_ENV=dev elixir:1.18.3 bash
  * docker stop portal_int
  * docker start portal_int
  * docker exec -it portal_int bash
* apt-get update
* apt-get -y install inotify-tools
* apt-get -y install nodejs npm
* mix local.hex
* mix archive.install hex phx_new 1.7.21
<hr/>

* cd apps/portal_int
* mix setup
* mix phx.server
* mix release --overwrite
* /suite/_build/dev/rel/portal_int/bin/portal_int start

## Building an image and running it
* Add a Dockerfile and .dockerignore file
* REMOVE ALL BUILD RESOURCES, otherwise docker try to use the files in the host system (MacOS):
  * rm -rf apps/portal_int/_build/
  * rm -rf apps/portal_int/deps/
  * rm -rf apps/portal_int/priv/static/assets
* In root directory "suite/":
  * Build image (verbose):
    * docker build -t portal_int:0.1.0 -f apps/portal_int/Dockerfile --no-cache --progress=plain .
  * Build image (not verbose)
    * docker build -t portal_int:0.1.0 -f apps/portal_int/Dockerfile .
  * docker run --name web_portal_int -p 4000:4000/tcp -t portal_int:0.1.0
  * docker stop web_portal_int
  * docker start web_portal_int
  * docker exec -it web_portal_int sh

## Ports
<pre>
            http   postgres
portal int  4000   6000
toggles     4010   6010
aku int     4100   6100

portal ext  5000   7000
aku ext     5100   7100

Locations where ports are found:
* Dockerfile
* README.md
* dev.exs
* runtime.exs
</pre>

* In root directory "suite/":
  * docker build -t portal_int:0.1.0 -f apps/portal_int/Dockerfile .
  * docker run --name portal_int -p 4000:4000/tcp -t portal_int:0.1.0
  * docker build -t toggles:0.1.0 -f apps/toggles/Dockerfile .
  * docker run --name toggles -p 4010:4010/tcp -t toggles:0.1.0
  * docker build -t aku_int:0.1.0 -f apps/aku_int/Dockerfile .
  * docker run --name aku_int -p 4100:4100/tcp -t aku_int:0.1.0

  * docker build -t portal_ext:0.1.0 -f apps/portal_ext/Dockerfile .
  * docker run --name portal_ext -p 5000:5000/tcp -t portal_ext:0.1.0
  * docker build -t aku_ext:0.1.0 -f apps/aku_ext/Dockerfile .
  * docker run --name aku_ext -p 5100:5100/tcp -t aku_ext:0.1.0
