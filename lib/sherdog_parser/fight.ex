defmodule SherdogParser.Fight do
  @moduledoc """
  Documentation for SherdogParser.Fight.
  """
  alias __MODULE__
  alias SherdogParser.Event

  defstruct fighter: "",
            result: nil,
            method: "",
            round: 1,
            date: nil,
            referee: "",
            event: %Event{}

  def new(fighter, result, method, round, date, referee, event) do
    %Fight{
      fighter: fighter,
      result: result,
      method: method,
      round: round,
      date: date,
      referee: referee,
      event: event
    }
  end
end
