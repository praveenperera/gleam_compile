defmodule GleamCompile.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :gleam_compile,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: Mix.compilers(),

      # hex
      description:
        "A tiny hex package makes it easier to use gleam in elixir and phoenix projects ",
      package: package(),

      # docs
      source_url: "https://github.com/praveenperera/gleam_compile",
      homepage_url: "https://github.com/praveenperera/gleam_compile",
      docs: docs()
    ]
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Praveen Perera"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/praveenperera/gleam_compile"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      markdown_processor: ExDoc.Markdown.Earmark,
      extras: ["README.md", "CHANGELOG.md", "LICENSE.md"],
      source_ref: "v#{@version}"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.21.3", only: :dev, runtime: false}]
  end
end
