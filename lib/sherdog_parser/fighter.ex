defmodule SherdogParser.Fighter do
  defstruct name: "", link: "", birthday: nil, birthplace: {}, height: 0, weight: 0, fights: []

  def new(name, link, birthday, birthplace, height, weight, fights \\ []) do
    %__MODULE__{
      name: name,
      birthday: birthday,
      birthplace: birthplace,
      height: height,
      weight: weight,
      link: link,
      fights: fights
    }
  end
end
