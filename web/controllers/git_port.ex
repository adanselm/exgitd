defmodule Exgitd.GitPort do

  def create_bare(repoPath) do
    command = "git init --bare " <> repoPath
    Port.open({:spawn, command}, [:binary, :exit_status])
    receive do
      {'EXIT', _port, reason} -> raise RuntimeError, message: reason
      {_port, {:exit_status, code}} -> code
    end
  end

  def receive_pack(repoPath) do
    advertise(repoPath, "git-receive-pack")
  end

  def upload_pack(repoPath) do
    advertise(repoPath, "git-upload-pack")
  end

  def post_receive_pack(repoPath, data) do
    result(repoPath, data, "git-receive-pack")
  end

  def post_upload_pack(repoPath, data) do
    result(repoPath, data, "git-upload-pack")
  end

  defp advertise(repoPath, service) when is_bitstring(service) do
    command = service <> " --stateless-rpc --advertise-refs " <> repoPath
    Port.open({:spawn, command}, [:binary, :exit_status])
    do_receive
  end

  defp result(repoPath, data, service) when is_bitstring(service) do
    command = service <> " --stateless-rpc " <> repoPath
    p = Port.open({:spawn, command}, [:binary, :exit_status])

    Port.command p, data
    do_receive
  end

  defp do_receive do
    do_receive("")
  end
  defp do_receive(data) do
    receive do
      {_port, {:data, newdata}} -> do_receive(data <> newdata)
      {'EXIT', _port, reason} -> raise RuntimeError, message: reason
      {_port, {:exit_status, _}} -> data
    end
  end

end
