defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias __MODULE__

  defstruct [
    title: "",
    subtitle: "",
    date: nil,
    organization_url: "", 
    location: ""
  ]

  def new(title, date, location \\ "") do
    %Event{
      title: title,
      date: date,
      location: location
    }
  end
end
