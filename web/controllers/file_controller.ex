defmodule Exgitd.FileController do
  use Phoenix.Controller
  plug :action

  ## Create full files store path on server
  defp make_path() do
    pathroot = Application.get_env(:exgitd, :repositories_root)
    path = Path.join [pathroot, "..", "files"]
    unless File.exists?(path) do
      File.mkdir(path)
    end
    path
  end

  def store_file(conn, %{"user" => _user, "file" => file}) do
    root_path = make_path()
    %{:filename => filename, :path => path} = file
    dest_path = Path.join [root_path, filename]
    case File.cp(path, dest_path, fn(_, _) -> false end) do
      :ok -> send_resp conn, 200, "OK"
      {:error, reason} -> raise RuntimeError,
                                message: "File #{dest_path} could not be copied: #{reason}"
    end
  end


end

