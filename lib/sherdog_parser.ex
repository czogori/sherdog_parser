defmodule SherdogParser do
  @moduledoc """
  Documentation for SherdogParser.
  """

  alias SherdogParser.{EventParser, FighterParser, OrganizationParser}

  defdelegate event(html), to: EventParser, as: :parse
  defdelegate fighter(html), to: FighterParser, as: :parse
  defdelegate organization(html), to: OrganizationParser, as: :parse
end
