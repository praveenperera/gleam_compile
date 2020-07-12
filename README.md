<p align="center"><img alt="GleamCompile" src="https://praveenperera.github.io/gleam_compile/logo.svg" height="50px"></img></p>
<p align="center">Elixir + Gleam = ❤️ </p>
<p align="center">
    <a href="https://hex.pm/packages/gleam_compile"><img alt="Hex.pm" src="https://img.shields.io/hexpm/l/gleam_compile"></a>
    <a href="https://hex.pm/packages/gleam_compile"><img alt="Hex.pm" src="https://img.shields.io/hexpm/v/gleam_compile"></a>
    <a href="https://hex.pm/packages/gleam_compile"><img alt="Hex.pm" src="https://img.shields.io/hexpm/dt/gleam_compile"></a>
    <a href="https://hexdocs.pm/gleam_compile"><img alt="HexDocs.pm" src="https://img.shields.io/badge/hex-docs-purple.svg"></a>
</p>

---

## Description

A tiny hex package makes it easier to use [gleam](https://github.com/gleam-lang/gleam) in elixir and phoenix projects

This package does two things

1. Runs the gleam compiler
2. In development it automatically reloads the gleam files when recompiled

**Demo with Phoenix Live Reload**

<img src="https://praveenperera.github.io/gleam_compile/demo.gif?raw=true" alt="Explainer" width="750px">

## Installation

**_Note: Make sure [gleam](https://github.com/gleam-lang/gleam) is already installed on your system._**

This package is available on [hex](https://hex.pm/packages/gleam_compile).

1. The package can be installed by adding `gleam_compile` to your list of dependencies in `mix.exs`:

   ```elixir
   def deps do
     [
       {:gleam_compile, "~> 0.2.0"}
     ]
   end
   ```

2. Add `:gleam` to list of compilers in your `mix.exs`

   ```diff
   def project do
     [
      app: :jib,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      erlc_paths: ["src", "gen"],
   +  compilers: [:gleam],
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      aliases: aliases(),
      deps: deps()
     ]
   end
   ```

## Intergrating with Phoenix Live Reloader

1. Add `:gleam` to list of compilers in your `mix.exs`

   ```elixir
   compilers: [:phoenix, :gettext, :gleam] ++ Mix.compilers()
   ```

   ```diff
     def project do
    [
      app: :jib,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      erlc_paths: ["src", "gen"],
   -  compilers: [:phoenix, :gettext] ++ Mix.compilers(),
   +  compilers: [:phoenix, :gettext, :gleam] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      aliases: aliases(),
      deps: deps()
    ]
   end
   ```

2. In `dev.exs` add this line in the `Endpoint` config

   ```elixir
   reloadable_compilers: [:gettext, :phoenix, :elixir, :gleam],
   ```

   ```diff
   config :my_app, MyAppWeb.Endpoint,
     http: [port: 4000],
     debug_errors: true,
     code_reloader: true,
     check_origin: false,
   + reloadable_compilers: [:gettext, :phoenix, :elixir, :gleam],
     watchers: [
       node: [
         "node_modules/webpack/bin/webpack.js",
         "--mode",
         "development",
         "--watch-stdin",
         cd: Path.expand("../assets", __DIR__)
       ]
     ]
   ```

3. Add gleam files to the live_reload patterns

   ```elixir
   ~r"src/.*(gleam)$",
   ```

   ```diff
   config :my_app, MyAppWeb.Endpoint,
     live_reload: [
       patterns: [
         ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
         ~r"priv/gettext/.*(po)$",
   +     ~r"src/.*(gleam)$",
         ~r"lib/jib_web/{live,views}/.*(ex)$",
         ~r"lib/jib_web/templates/.*(eex)$"
       ]
     ]
   ```

## License

GleamCompile is released under the Apache License 2.0 - see the [LICENSE](LICENSE.md) file.
