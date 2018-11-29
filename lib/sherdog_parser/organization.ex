defmodule SherdogParser.Organization do
  @moduledoc """
  Documentation for SherdogParser.Organization.
  """

  defstruct name: "", events: []

  def new(name, events) do
    %__MODULE__{
      name: name,
      events: events
    }
  end
end
