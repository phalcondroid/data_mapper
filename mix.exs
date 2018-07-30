defmodule DataMapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :data_mapper,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      #mod: { DataMapper, [] },
      extra_applications: [
        :logger,
        :ex_aws,
        :ex_aws_dynamo,
        :poison,
        :hackney
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.0"},
      {:ex_aws_dynamo, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.9"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
