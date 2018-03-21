defmodule PasswordLock.MixProject do
  use Mix.Project

  def project do
    [
      app: :password_lock,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "password app",
      aliases: aliases(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def aliases do
    [c: "compile"]
  end

  def docs do
    [
      main: "PasswordLock",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: [" Nick C "],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/flowerett/password_lock"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
