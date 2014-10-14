defmodule Exgitd.Router do
  use Phoenix.Router

  get "/", Exgitd.PageController, :index, as: :pages

  get "/:user/", Exgitd.GitController, :index

  scope path: "/:user/:repo" do
    get "/info/refs", Exgitd.GitController, :get_info_refs
    post "/git-receive-pack", Exgitd.GitController, :post_receive_pack
    post "/git-upload-pack", Exgitd.GitController, :post_upload_pack
    post "/", Exgitd.GitController, :create
  end
end