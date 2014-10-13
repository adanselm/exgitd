# Exgitd

Simple Elixir/[Phoenix] app acting as a Git Smart HTTP server.

[Phoenix]: https://github.com/phoenixframework/phoenix

## Config

In your application's config.exs :

```elixir
config :exgitd, [repositories_root: "/tmp/"]
```

repositories_root is the directory where Exgitd will look for your repositories.

## Installation

```bash
$ mix do: deps.get, compile
$ mix phoenix.start
```

## Usage

Say I have a bare git repository in `/tmp/myuser/myrepo.git`

```bash
$ # This will create a `myrepo` directory with a clone of the repo:

$ git clone http://localhost:4000/myuser/myrepo.git

$ # This pulls the changes from the master branch:

$ git pull http://localhost:4000/myuser/myrepo.git master

$ # I made local changes that I commited, push them:

$ git push http://localhost:4000/myuser/myrepo.git master
```

** If you're using it anywhere else than localhost, you should consider using https...**

##TODO

- No AUTH!
- No Error handling
- No tests

## Resources

Articles used to base this code on.

* [Git HTTP transport protocol documentation](https://gist.github.com/schacon/6092633)
* [Implementing a Git HTTP Server](http://www.michaelfcollins3.me/blog/2012/05/18/implementing-a-git-http-server.html)

## Licensing
Copyright © 2014 [Adrien Anselme](https://github.com/adanselm) and [contributors](https://github.com/adanselm/exgitd/graphs/contributors)
MIT license. See COPYING for details.
