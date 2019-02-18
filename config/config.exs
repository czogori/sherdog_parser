# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

if Mix.env == :dev do
  config :pre_commit,
    commands: ["credo --strict", "test"],
    verbose: true
end