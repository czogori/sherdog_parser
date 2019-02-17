defmodule SherdogParser.Organization do
  @moduledoc """
  Documentation for SherdogParser.Organization.
  """

  defstruct name: "", event_urls: []

  def new(name, event_urls) do
    %__MODULE__{
      name: name,
      event_urls: event_urls
    }
  end
end
