defmodule SherdogParser.FightsParser do
  alias SherdogParser.FightParser

  def parse(html) do
    parse_fights(html)
  end

  defp parse_fights(html) do
    fights =
      html
      |> Floki.find("div.module.fight_history")
      |> find()

    case fights do
      {"div", _, [{"table", _, data}]} ->
        data
        |> Enum.drop(1)
        |> Enum.map(fn f -> FightParser.parse(f) end)

      :not_found ->
        :not_found
    end
  end

  defp find([]), do: :not_found

  defp find([h | t]) do
    case h do
      {"div", _, [{"div", _, [{"h2", _, ["Fight History - Pro"]}]}, data]} -> data
      _ -> find(t)
    end
  end
end
