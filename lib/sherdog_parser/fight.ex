defmodule SherdogParser.Fight do
  @moduledoc """
  Documentation for SherdogParser.Fight.
  """
  use TypedStruct

  @typedoc "A fight"
  typedstruct do
    field(:fighter_a_id, String.t(), enforce: true)
    field(:fighter_a_name, String.t(), enforce: true)
    field(:fighter_b_id, String.t(), enforce: true)
    field(:fighter_b_name, String.t(), enforce: true)
    field(:result, atom(), enforce: true)
    field(:method, String.t(), enforce: true)
    field(:round, non_neg_integer())
    field(:referee, String.t())
    field(:time, Time.t())
  end
end
