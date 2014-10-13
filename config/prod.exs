use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Exgitd.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_exgitd_key",
  session_secret: "HQ#FRQ#Q6T3H%#Y%!S14X63U2TOQ2^TQJ9*J6I(BG)!GJ_M34_%R8(3)H$Y!BI_V1="

config :logger, :console,
  level: :info,
  metadata: [:request_id]

