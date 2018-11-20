defmodule SherdogParser.FighterUrl do
  @moduledoc """
  Unique address for a fighter.
  """
  defstruct url: ""

  def new(url) do
    %__MODULE__{
      url: url
    }
  end
end
