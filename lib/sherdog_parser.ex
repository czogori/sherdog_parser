defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.{EventParser, FighterParser, OrganizationParser}

  def event(html), do: EventParser.parse(html)
  def fighter(html), do: FighterParser.parse(html)
  def organization(html), do: OrganizationParser.parse(html)
end
