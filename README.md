# Suite

Starting nginx and all containers

    docker-compose up --build

Once everything is build an running you can access the
assembled product page via
[http://127.0.0.1:3000/](http://127.0.0.1:3000/).

### Fix deps/phoenix_live_reload/lib/phoenix_live_reload/live_reload.ex:
* line 126: url = config[:url] || endpoint.path("/portal/phoenix/live_reload/socket#{suffix(endpoint)}")
* line 184: path = conn.private.phoenix_endpoint.path("/portal/phoenix/live_reload/frame#{suffix(endpoint)}")
<hr/>

* Log
<hr/>

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
  * docker run --name web_portal -p 4000:4000/tcp -t portal:0.1.0
  * docker stop web_portal
  * docker start web_portal
  * docker exec -it web_portal sh

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
  * docker build -t portal:0.1.0 -f apps/portal/Dockerfile .
  * docker run --name portal -p 4000:4000/tcp -t portal:0.1.0
  * docker build -t toggles:0.1.0 -f apps/toggles/Dockerfile .
  * docker run --name toggles -p 4010:4010/tcp -t toggles:0.1.0
  * docker build -t aku:0.1.0 -f apps/aku/Dockerfile .
  * docker run --name aku -p 4100:4100/tcp -t aku:0.1.0

## Patch deps/phoenix_live_reload/lib/phoenix_live_reload/live_reload.ex
In order to use a \<root\> tag instead of \<body\> patch live_reload.ex like so:

<pre>
  def call(%Plug.Conn{path_info: ["phoenix", "live_reload", "frame" | _suffix]} = conn, _) do
    endpoint = conn.private.phoenix_endpoint
    config = endpoint.config(:live_reload)
    url = config[:url] || endpoint.path("/portal/phoenix/live_reload/socket#{suffix(endpoint)}")
    interval = config[:interval] || 100
    .
    .
    .

  -------------------------

  defp body_tag, do: "root"

  defp before_send_inject_reloader(conn, endpoint, config) do
    register_before_send(conn, fn conn ->
      if conn.resp_body != nil and html?(conn) do
        resp_body = IO.iodata_to_binary(conn.resp_body)

        if has_body?(resp_body) and :code.is_loaded(endpoint) do
          {head, [last]} = Enum.split(String.split(resp_body, "</#{body_tag()}>"), -1)
          head = Enum.intersperse(head, "</#{body_tag()}>")
          body = [head, reload_assets_tag(conn, endpoint, config), "</#{body_tag()}>" | last]
          put_in(conn.resp_body, body)
        else
          conn
        end
      else
        conn
      end
    end)
  end

  defp html?(conn) do
    case get_resp_header(conn, "content-type") do
      [] -> false
      [type | _] -> String.starts_with?(type, "text/html")
    end
  end

  defp has_body?(resp_body), do: String.contains?(resp_body, "<#{body_tag()}")

  defp reload_assets_tag(conn, endpoint, config) do
    path = conn.private.phoenix_endpoint.path("/portal/phoenix/live_reload/frame#{suffix(endpoint)}")
</pre>

## VSCodeVIM / Mac
To enable key-repeating, execute the following in your Terminal, log out and back in, and then restart VS Code:
<pre>
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false              # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false      # For VS Code Insider
defaults write com.vscodium ApplePressAndHoldEnabled -bool false                      # For VS Codium
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false   # For VS Codium Exploration users
defaults delete -g ApplePressAndHoldEnabled                                           # If necessary, reset global default
</pre>

## In phoenix_live_view

* npm run setup
* mix release
* mix assets.build
