defmodule SherdogParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :sherdog_parser,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.10.0", only: :dev, runtime: false},
      {:dialyxir, "~> 0.4", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},
      {:floki, "~> 0.20.0"},
      {:httpoison, "~> 1.4", only: :dev},
      {:pre_commit, "~> 0.3.4", only: :dev},
      {:typed_struct, "~> 0.1.4"},
      {:date_time_parser, "~> 0.1.3"}
    ]
  end
end
