defmodule SherdogParser.EventParser do
  @moduledoc """
  Documentation for SherdogParser.EventParser.
  """

  alias SherdogParser.{Event, Fight}
  use Timex

  def parse(html) do
    {title, subtitle} = parse_title(html)
    date = parse_date(html)
    fights = parse_fights(html)

    %Event{
      title: title,
      subtitle: subtitle,
      date: date,
      location: parse_location(html),
      organization_url: parse_organization_url(html),
      main_fight: List.last(fights),
      fights: fights
    }
  end

  defp parse_title(html) do
    case Floki.find(html, "div.header > div.section_title > h1 > span") do
      [{"span", [{"itemprop", "name"}], [title, {"br", [], []}, subtitle]}] ->
        {title, subtitle}

      error ->
        error
    end
  end

  defp parse_organization_url(html) do
    [{"a", [_, {"href", url}], _}] =
      Floki.find(html, "div.header > div.section_title > h2 > div > a")

    url
  end

  defp parse_date(html) do
    [{_, _, [{_, _, _}, date]}] =
      Floki.find(html, "div.header > div.info > div.authors_info > span.date")

    case DateTimeParser.parse_date(date) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp parse_location(html) do
    [{_, _, [_, {_, _, [location]}]}] =
      Floki.find(html, "div.header > div.info > div.authors_info > span.author")

    location
  end

  def parse_main_fight(html) do
    [a, b] = Floki.find(html, "div.module.fight_card div[itemprop=performer]")

    {fighter_a_id, fighter_a_name, fighter_a_result} = parse_main_figter(a)
    {fighter_b_id, fighter_b_name, fighter_b_result} = parse_main_figter(b)

    [
      {"td", _, [_, _, fight_number]},
      {"td", _, [_, _, method]},
      {"td", _, [_, _, referee]},
      {"td", _, [_, _, round]},
      {"td", _, [_, _, time]}
    ] = Floki.find(html, "div.module.fight_card > div.content.event > div.footer  td")

    method =
      method
      |> String.trim()
      |> Fight.method()

    %Fight{
      fighter_a_id: fighter_a_id,
      fighter_a_name: fighter_a_name,
      fighter_b_id: fighter_b_id,
      fighter_b_name: fighter_b_name,
      result: fighter_a_result |> Fight.get_result(),
      referee: referee |> String.trim(),
      round: round |> String.trim() |> String.to_integer(),
      method: method,
      time: Fight.parse_time(time)
    }
  end

  defp parse_main_figter(fighter) do
    {"div", _,
     [
       _,
       {"h3", [],
        [
          {"a", [{"href", fighter_id}], [{_, _, [name]}]}
        ]},
       {"span", _, [result]},
       _
     ]} = fighter

    {fighter_id, name, result}
  end

  def parse_fights(html) do
    main_fight = parse_main_fight(html)

    fights =
      html
      |> Floki.find("div.module.event_match tr[itemprop=subEvent")
      |> Enum.map(&parse_fight/1)
      |> Enum.reverse()
      |> Kernel.++([main_fight])
  end

  defp parse_fight(fight) do
    {"tr", _,
     [
       _,
       {"td", _,
        [
          {"meta", _, []},
          _,
          {"div", [{"class", "fighter_result_data"}],
           [
             {"a", [{"itemprop", "url"}, {"href", fighter_a_id}],
              [{"span", [{"itemprop", "name"}], [fighter_a_name]}]},
             {"br", [], []},
             {"span", _, [fighter_a_result]}
           ]}
        ]},
       _,
       {"td", _,
        [
          _,
          _,
          {"div", [{"class", "fighter_result_data"}],
           [
             {"a", [{"itemprop", "url"}, {"href", fighter_b_id}],
              [{"span", [{"itemprop", "name"}], [fighter_b_name]}]},
             {"br", [], []},
             _
           ]}
        ]},
       {"td", [],
        [
          method,
          _,
          {"span", _, [referee]}
        ]},
       {"td", [], [round]},
       {"td", [], [time]}
     ]} = fight

    %Fight{
      fighter_a_id: fighter_a_id,
      fighter_a_name: fighter_a_name,
      fighter_b_id: fighter_b_id,
      fighter_b_name: fighter_b_name,
      result: fighter_a_result |> Fight.get_result(),
      referee: referee |> String.trim(),
      round: round |> String.trim() |> String.to_integer(),
      method: Fight.method(method),
      time: Fight.parse_time(time)
    }
  end
end
