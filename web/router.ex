defmodule Exgitd.Router do
  use Phoenix.Router

  scope "/" do
    pipe_through :browser

    get "/", Exgitd.PageController, :index, as: :pages
  end

  scope "git/:user" do
    pipe_through :browser

    get "/", Exgitd.GitController, :index

    scope "/:repo" do
      get "/info/refs", Exgitd.GitController, :get_info_refs
      post "/git-receive-pack", Exgitd.GitController, :post_receive_pack
      post "/git-upload-pack", Exgitd.GitController, :post_upload_pack
      post "/", Exgitd.GitController, :create
    end
  end
end
