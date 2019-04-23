defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias __MODULE__
  alias SherdogParser.Fight

  defstruct [
    id: "",
    title: "",
    subtitle: "",
    date: nil,
    organization_url: "",
    location: "",
    fights: [],
    main_event: %Fight{}
  ]

  def new(id, title, date, location \\ "") do
    %Event{
      id: id,
      title: title,
      date: date,
      location: location
    }
  end
end
