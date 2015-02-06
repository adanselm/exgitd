defmodule Exgitd.GitController do
  use Phoenix.Controller
  alias Exgitd.GitPort
  plug :action

  ## Create full repo path on server from username and repo name
  defp make_path(user, repo_name) do
    pathroot = Application.get_env(:exgitd, :repositories_root)
    unless String.ends_with?(repo_name, ".git"), do: repo_name = repo_name <> ".git"
    Path.join [pathroot, user, repo_name]
  end
  defp make_path(user) do
    pathroot = Application.get_env(:exgitd, :repositories_root)
    Path.join [pathroot, user]
  end

  def index(conn, %{"user" => user}) do
    full_path = make_path(user)
    {:ok, list} = File.ls(full_path)
    text = List.foldr(list, "", fn (x, acc) -> x <> "\n" <> acc end)
    send_packet conn, "text/plain", text
  end

  def create(conn, %{"repo" => repo, "user" => user}) do
    full_path = make_path(user, repo)
    GitPort.create_bare(full_path)
    send_packet conn, "text/plain", full_path
  end

  def get_info_refs(conn, %{"service" => "git-receive-pack", "repo" => repo, "user" => user}) do
    packet = pkt_line("# service=git-receive-pack\n")
    packet = packet <> GitPort.receive_pack(make_path(user, repo))

    #IO.puts to_string(packet)
    send_packet conn, "application/x-git-receive-pack-advertisement", packet
  end

  def get_info_refs(conn, %{"service" => "git-upload-pack", "repo" => repo, "user" => user}) do
    packet = pkt_line("# service=git-upload-pack\n")
    packet = packet <> GitPort.upload_pack(make_path(user, repo))

    #IO.puts to_string(packet)
    send_packet conn, "application/x-git-upload-pack-advertisement", packet
  end

  defp pkt_line(line) do
    packetSize = Integer.to_string(String.length(line) + 4, 16)
    packetSize = String.rjust(String.downcase(packetSize), 4, ?0)
    "#{packetSize}#{line}0000"
  end

  def post_receive_pack(conn, %{"repo" => repo, "user" => user}) do
    data = read_long_body(conn)

    packet = GitPort.post_receive_pack(make_path(user, repo), data)

    #IO.inspect packet
    send_packet conn, "application/x-git-receive-pack-result", packet
  end

  def post_upload_pack(conn, %{"repo" => repo, "user" => user}) do
    data = read_long_body(conn)

    packet = GitPort.post_upload_pack(make_path(user, repo), data)

    #IO.inspect packet
    send_packet conn, "application/x-git-upload-pack-result", packet
  end

  defp send_packet(conn, content_type, data) do
    # Can't use Phoenix shortcuts because we need to control the
    # content type and charset.
    conn
    |> put_resp_header("Expires", "Fri, 01 Jan 1980 00:00:00 GMT")
    |> put_resp_header("Cache-Control", "no-cache, max-age=0, must-revalidate")
    |> put_resp_header("Pragma", "no-cache")
    |> put_resp_content_type(content_type, nil)
    |> send_resp 200, data
  end

  defp read_long_body(conn) do
    read_long_body conn, ""
  end
  defp read_long_body(conn, acc) do
    case read_body(conn) do
      {:ok, data, _rest} -> acc <> data
      {:more, partial, rest} -> read_long_body(rest, acc <> partial)
    end
  end

end

