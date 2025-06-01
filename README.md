# Suite

Starting nginx and all containers

    docker-compose up --build

Once everything is build an running you can access the
assembled product page via
[http://127.0.0.1:3000/](http://127.0.0.1:3000/).

## Custom Phoenix Live Reload and Phoenix Live View
In mix.exs use the custom phoenix_live_reload and phoenix_live_view git repositories (in "custom/" directory)

## Fixing custom phoenix_live_view

* npm run setup
* mix release
* mix assets.build

## Log

* mix local.hex
* mix archive.install hex phx_new 1.7.21
<hr/>

* docker volume create db_data_portal
* docker run --name db-portal -v db_data_portal:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6000:5432 postgres:17.4-alpine3.21
* docker volume create db_data_toggles
* docker run --name db-toggles -v db_data_toggles:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6010:5432 postgres:17.4-alpine3.21
* docker volume create db_data_aku
* docker run --name db-aku -v db_data_aku:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 6100:5432 postgres:17.4-alpine3.21
<hr/>


* mix phx.new portal
* manually fix all files in "config/" dir
* mix setup # (deps.get, assets.setup, deps.compile, ecto.create, etc)
* mix phx.server

## Compiling and running inside a docker container
* docker volume create mix_portal
* docker run -it --name portal -v mix_portal:/root/.mix --volume=".":/suite:rw -w /suite -p 4000:4000/tcp -e MIX_ENV=dev elixir:1.18.3 bash
  * docker stop portal
  * docker start portal
  * docker exec -it portal bash
* apt-get update
* apt-get -y install inotify-tools
* apt-get -y install nodejs npm
* mix local.hex
* mix archive.install hex phx_new 1.7.21
<hr/>

* cd apps/portal
* mix setup
* mix phx.server
* mix release --overwrite
* /suite/_build/dev/rel/portal/bin/portal start

## Preparing to build a docker image

Make the following changes:
1. mix.exs, change custom git repo paths to:
<pre>
   {:phoenix_live_reload,
    git: "/custom/phoenix_live_reload",
    ...
   {:phoenix_live_view,
    git: "/custom/phoenix_live_view",
</pre>
2. dev.exs, change db hostname to:
<pre>
   hostname: "host.docker.internal",
</pre>
3. dev.exs, change endpoint binding to:
<pre>
   http: [ip: {0, 0, 0, 0}, port: 4000]
</pre>

## Building an image and running it
* Add a Dockerfile and .dockerignore file
* REMOVE ALL BUILD RESOURCES, otherwise docker try to use the files in the host system (MacOS):
  * rm -rf apps/portal/_build/
  * rm -rf apps/portal/deps/
  * rm -rf apps/portal/priv/static/assets
* In root directory "suite/":
  * Build image (verbose):
    * docker build -t portal:0.1.0 -f apps/portal/Dockerfile --no-cache --progress=plain .
  * Build image (not verbose)
    * docker build -t portal:0.1.0 -f apps/portal/Dockerfile .
  * docker run --name portal -p 4000:4000/tcp -t portal:0.1.0
  * docker stop portal
  * docker start portal
  * docker exec -it portal sh

## Ports
<pre>
            http   postgres
portal      4000   6000
toggles     4010   6010
aku         4100   6100

survey      5000   7000
aku_survey  5100   7100

Locations where ports are declared:
* Dockerfile
* README.md
* dev.exs
* runtime.exs
</pre>

* In root directory "suite/":
  * docker build -t portal:0.1.0 -f apps/portal/Dockerfile .
  * docker run --name portal -p 4000:4000/tcp -t portal:0.1.0
  * docker build -t toggles:0.1.0 -f apps/toggles/Dockerfile .
  * docker run --name toggles -p 4010:4010/tcp -t toggles:0.1.0
  * docker build -t aku:0.1.0 -f apps/aku/Dockerfile .
  * docker run --name aku -p 4100:4100/tcp -t aku:0.1.0

## VSCodeVIM / Mac
To enable key-repeating, execute the following in your Terminal, log out and back in, and then restart VS Code:
<pre>
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false              # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false      # For VS Code Insider
defaults write com.vscodium ApplePressAndHoldEnabled -bool false                      # For VS Codium
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false   # For VS Codium Exploration users
defaults delete -g ApplePressAndHoldEnabled                                           # If necessary, reset global default

IO.puts("*******> socket: #{socket |> inspect(pretty: true, limit:  :infinity, width:  120)}")
</pre>
