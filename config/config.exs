# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Exgitd.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_exgitd_key",
  session_secret: "HQ#FRQ#Q6T3H%#Y%!S14X63U2TOQ2^TQJ9*J6I(BG)!GJ_M34_%R8(3)H$Y!BI_V1=",
  catch_errors: true,
  debug_errors: false,
  error_controller: Exgitd.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exgitd, [repositories_root: "/tmp/"]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
