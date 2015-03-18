# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :exgitd, Exgitd.Endpoint,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  secret_key_base: "HQ#FRQ#Q6T3H%#Y%!S14X63U2TOQ2^TQJ9*J6I(BG)!GJ_M34_%R8(3)H$Y!BI_V1=",
  catch_errors: true,
  debug_errors: false,
  error_controller: Exgitd.PageController,
  parsers: [parsers: [:urlencoded, :multipart, :json],
            accept: ["*/*"],
            json_decoder: Poison,
            length: 100_000_000]

# Session configuration
config :exgitd, Exgitd.Endpoint,
  session: [store: :cookie,
            key: "_exgitd_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exgitd, [repositories_root: "/tmp/repositories"]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
