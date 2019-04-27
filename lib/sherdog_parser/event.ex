defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias SherdogParser.Fight

  defstruct id: "",
            title: "",
            subtitle: "",
            date: nil,
            organization_url: "",
            location: "",
            fights: [],
            main_event: %Fight{}
end
