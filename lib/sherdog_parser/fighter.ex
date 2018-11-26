defmodule SherdogParser.Fighter do
  @moduledoc """
  Documentation for SherdogParser.Fighter.
  """
  defstruct name: "", link: "", birthdate: nil, birthplace: {}, height: 0, weight: 0, fights: []

  def new(name, link, birthdate, birthplace, height, weight, fights \\ []) do
    %__MODULE__{
      name: name,
      birthdate: birthdate,
      birthplace: birthplace,
      height: height,
      weight: weight,
      link: link,
      fights: fights
    }
  end
end
