use Mix.Config

config :exgitd, MyApp.Endpoint,
  http: [port: System.get_env("PORT") || 4001],
  catch_errors: false
