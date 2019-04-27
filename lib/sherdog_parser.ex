defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.{EventParser, FighterParser, OrganizationParser}

  def event(html, id), do: EventParser.parse(html, id)
  def fighter(html), do: FighterParser.parse(html)
  def organization(html), do: OrganizationParser.parse(html)
end
