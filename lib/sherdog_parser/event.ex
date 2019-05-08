defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias SherdogParser.Fight

  defstruct title: "",
            subtitle: "",
            date: nil,
            organization_url: "",
            location: "",
            fights: [],
            main_fight: %Fight{}
end
