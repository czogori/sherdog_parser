defmodule SherdogParser.Event do
  @moduledoc """
  Documentation for SherdogParser.Event.
  """
  alias SherdogParser.Fight
  use TypedStruct

  @typedoc "An event"
  typedstruct do
    field :title, String.t(), enforce: true
    field :subtitle, String.t()
    field :date, Date.t(), enforce: true
    field :organization_url, String.t()
    field :location, String.t()
    field :fights, [%Fight{}]
    field :main_fight, %Fight{}
  end
end
