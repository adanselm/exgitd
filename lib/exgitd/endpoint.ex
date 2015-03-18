defmodule Exgitd.Endpoint do
  use Phoenix.Endpoint, otp_app: :exgitd

  plug Plug.Static,
    at: "/", from: :exgitd,
    only: ~w(files css images js favicon.ico robots.txt)

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison,
    length: 100_000_000

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_exgitd_key",
    signing_salt: "Nk+Z6Ojl",
    encryption_salt: "W6/l5rL/"

  plug :router, Exgitd.Router
end
