defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.FighterParser
  alias SherdogParser.OrganizationParser

  def fighter(html), do: FighterParser.parse(html)
  def fighter_ids(html), do: FighterParser.find_fighters_id(html)
  def organization(html), do: OrganizationParser.parse(html)
end
