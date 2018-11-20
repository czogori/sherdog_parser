defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias __MODULE__

  defstruct name: "", date: nil, link: ""

  def new(name, date, link) do
    %Event{
      name: name,
      date: date,
      link: link
    }
  end
end
