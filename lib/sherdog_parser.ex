defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.FighterParser

  def parse_fighter(html \\ "") do
    FighterParser.parse(html)
  end

  def find_fighters_id(html) do
    FighterParser.find_fighters_id(html)
  end
end
