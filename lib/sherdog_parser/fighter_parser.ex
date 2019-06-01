defmodule SherdogParser.FighterParser do
  @moduledoc """
  Documentation for SherdogParser.FighterParser.
  """
  alias SherdogParser.Fighter

  @unknown "N/A"

  def parse(html) do
    %Fighter{
      name: parse_name(html),
      link: "",
      birthdate: parse_birthdate(html),
      birthplace: parse_birtplace(html),
      height: parse_height(html),
      fights: parse_fights(html)
    }
  end

  def parse_item(item) do
    case item do
      {"a", [{"href", id}], _} -> id
      {"a", [_, {"href", id}], _} -> id
      {"a", [{"href", id}, _], _} -> id
      _ -> :not_found
    end
  end

  defp parse_name(html) do
    case Floki.find(html, "div.module.bio_fighter.vcard > h1") do
      [{"h1", _, [{_, _, [name]}, _]}] ->
        name

      [
        {"h1", _, [{"span", _, [name]}, _, {"span", _, ["\"", {"em", [], [nickname]}, "\""]}]}
      ] ->
        name

      _ ->
        :not_found
    end
  end

  defp parse_birthdate(html) do
    case Floki.find(html, "div.data > .bio > .birth_info > .item.birthday") do
      [{"span", _, [_, {"span", _, [@unknown]}, _, _]}] -> nil
      [{"span", _, [_, {"span", _, [date]}, _, _]}] -> Date.from_iso8601!(date)
      _ -> nil
    end
  end

  defp parse_birtplace(html) do
    case Floki.find(html, "div.data > .bio > .birth_info > .item.birthplace") do
      [
        {"span", _,
         [
           {"img", _, _},
           {"span", _,
            [
              {"span", _, [city]}
            ]},
           {"br", _, _},
           {"strong", _, [country]}
         ]}
      ] ->
        {country, city}

      _ ->
        nil
    end
  end

  defp parse_height(html) do
    case Floki.find(html, "div.data > .bio > .size_info > .item.height") do
      [{_, _, [_, _, _, _, height]}] ->
        height
        |> String.trim()
        |> String.trim_trailing(" cm")
        |> String.to_float()
        |> round

      _ ->
        nil
    end
  end

  defp parse_weight(html) do
    case Floki.find(html, "div.data > .bio > .size_info > .item.weight") do
      [{_, _, [_, _, _, _, weight]}] ->
        weight
        |> String.trim()
        |> String.trim_trailing(" kg")
        |> String.to_float()
        |> round

      _ ->
        nil
    end
  end

  def parse_fights(html) do
    Floki.find(html, "div.module.fight_history tr:not(.table_head)")
  end
end
