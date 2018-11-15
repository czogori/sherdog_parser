defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.FighterParser

  def parse_fighter(html \\ "") do
    FighterParser.parse(html)
  end

  def parse_orgnization(id \\ "") do
  end
end
