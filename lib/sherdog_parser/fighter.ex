defmodule SherdogParser.Fighter do
  @moduledoc """
  Documentation for SherdogParser.Fighter.
  """

  use TypedStruct

  @typedoc "A fighter"
  typedstruct do
    field(:name, String.t(), enforce: true)
    field(:link, String.t(), enforce: true)
    field(:nickname, String.t())
    field(:birthdate, Date.t())
    field(:birthplace, String.t())
    field(:height, non_neg_integer())
    field(:association, String.t())
    field(:fights, [%SherdogParser.Fight{}])
  end
end
