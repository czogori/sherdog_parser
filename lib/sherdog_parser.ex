defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.FighterParser

  def fighter(html) do
    FighterParser.parse(html)
  end

  def fighter_ids(html) do
    FighterParser.find_fighters_id(html)
  end
end
