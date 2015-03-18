use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :exgitd, MyApp.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "I4y2mtwIMgistgYT3u8ruU9yUwsopu6FHo9gex3gtorEKdMSuzjRfu0XownGjjQP7MWXtBx8sK1VP6IzhVzwtw=="

config :logger, :console,
  level: :info
