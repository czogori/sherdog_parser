defmodule SherdogParser.Organization do
  @moduledoc """
  Documentation for SherdogParser.Organization.
  """
  use TypedStruct

  @typedoc "An organization"
  typedstruct do
    field :name, String.t(), enforce: true
    field :event_urls, [String.t()], enforce: true
  end
end
