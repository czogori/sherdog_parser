defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias __MODULE__

  defstruct name: "", date: nil, link: "", location: ""

  def new(name, date, link, location \\ "") do
    %Event{
      name: name,
      date: date,
      link: link,
      location: location
    }
  end
end
