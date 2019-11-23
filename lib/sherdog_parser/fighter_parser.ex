defmodule SherdogParser.FighterParser do
  @moduledoc """
  Documentation for SherdogParser.FighterParser.
  """
  alias SherdogParser.{Fight, Fighter}

  @unknown "N/A"

  def parse(html) do
    {name, nickname} = parse_name(html)

    %Fighter{
      name: name,
      nickname: nickname,
      link: "",
      birthdate: parse_birthdate(html),
      birthplace: parse_birtplace(html),
      height: parse_height(html),
      fights: parse_fights(html, name)
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
        {name, nil}

      [
        {"h1", _, [{"span", _, [name]}, _, {"span", _, ["\"", {"em", [], [nickname]}, "\""]}]}
      ] ->
        {name, nickname}

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

  def parse_fights(html, name) do
    html
    |> Floki.find("div.module.fight_history tr:not(.table_head)")
    |> Enum.map(fn f -> parse_fight(f, name) end)
    |> Enum.reverse()
  end

  def parse_fight(fight, name) do
    {"tr", _,
     [
       result,
       fighter_b,
       event,
       method,
       round,
       time
     ]} = fight

    {fighter_b_id, fighter_b_name} = parse_fighter(fighter_b)
    {method, referee} = parse_method(method)
    {event_id, event_name, event_date} = parse_event(event)

    {:ok, event_date} =
      event_date
      |> String.replace("/", "")
      |> DateTimeParser.parse_date()

    %Fight{
      fighter_a_id: "",
      fighter_a_name: name,
      fighter_b_id: fighter_b_id,
      fighter_b_name: fighter_b_name,
      result: parse_result(result),
      referee: referee,
      round: parse_round(round),
      method: Fight.method(method),
      time: time |> parse_time() |> Fight.parse_time(),
      event_id: event_id,
      event_name: event_name,
      event_date: event_date
    }
  end

  def parse_fighter({"td", _, [{"a", [{"href", id}], [name]}]}), do: {id, name}

  def parse_event({"td", _, [{"a", [{"href", event_id}], [{_, _, [name]}]}, _, {_, _, [date]}]}),
    do: {event_id, name, date}

  def parse_event({"td", _, [{"a", [{"href", event_id}], [name]}, _, {_, _, [date]}]}),
    do: {event_id, name, date}

  def parse_round({"td", [], [round]}), do: String.to_integer(round)
  def parse_time({"td", [], [time]}), do: time
  def parse_method({"td", _, [method, _, {_, _, [referee]}]}), do: {method, referee}
  def parse_result({_, _, [{_, _, ["win"]}]}), do: :fighter_a
  def parse_result({_, _, [{_, _, ["loss"]}]}), do: :fighter_b
  def parse_result({_, _, [{_, _, ["draw"]}]}), do: :draw
end
