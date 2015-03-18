defmodule Exgitd.PageController do
  use Phoenix.Controller
  plug :action

  def index(conn, _params) do
    conn |> render "index.html" |> halt
  end

  def not_found(conn, _params) do
    conn |> render "not_found.html" |> halt
  end

  def error(conn, _params) do
    conn |> render "error.html" |> halt
  end
end
