defmodule SherdogParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :sherdog_parser,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:httpoison, "~> 1.4", only: [:dev, :test]},
      {:floki, "~> 0.20.0"},
      {:timex, "~> 3.0"},
      {:dialyxir, "~> 0.4", only: [:dev]},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false}
    ]
  end
end
