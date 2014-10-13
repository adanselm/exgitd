use Mix.Config

config :phoenix, Exgitd.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_exgitd_key",
  session_secret: "HQ#FRQ#Q6T3H%#Y%!S14X63U2TOQ2^TQJ9*J6I(BG)!GJ_M34_%R8(3)H$Y!BI_V1=",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


