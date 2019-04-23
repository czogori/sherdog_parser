defmodule SherdogParser.Fight do
  @moduledoc """
  Documentation for SherdogParser.Fight.
  """
  alias __MODULE__

  defstruct [
    fighter_a_id: "",
    fighter_b_id: "",
    result: nil,
    method: "",
    round: 0,
    date: nil,
    referee: "",
    event_id: "",
    time: ~T[00:00:00]
  ]
end
