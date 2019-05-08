defmodule SherdogParser.EventParser do
  @moduledoc """
  Documentation for SherdogParser.EventParser.
  """

  alias SherdogParser.Event
  alias SherdogParser.Fight
  use Timex

  def parse(html) do
    {title, subtitle} = parse_title(html)
    date = parse_date(html)

    %Event{
      title: title,
      subtitle: subtitle,
      date: date,
      location: parse_location(html),
      organization_url: parse_organization_url(html),
      main_fight: html |> parse_main_fight() |> struct(%{date: date})
    }
  end

  defp parse_title(html) do
    case Floki.find(html, "div.header > div.section_title > h1 > span") do
      [{"span", [{"itemprop", "name"}], [title, {"br", [], []}, subtitle]}] ->
        {title, subtitle}

      error ->
        error

      _ ->
        "foo"
    end
  end

  defp parse_organization_url(html) do
    [{"a", [_, {"href", url}], _}] =
      Floki.find(html, "div.header > div.section_title > h2 > div > a")

    url
  end

  defp parse_date(html) do
    [{_, _, [{_, [_, {"content", date}], _}, _]}] =
      Floki.find(html, "div.header > div.info > div.authors_info > span.date")

    date
    |> Timex.parse!("{ISO:Extended}")
    |> DateTime.to_date()
  end

  defp parse_location(html) do
    [{_, _, [_, {_, _, [location]}]}] =
      Floki.find(html, "div.header > div.info > div.authors_info > span.author")

    location
  end

  def parse_main_fight(html) do
    [a, b] = Floki.find(html, "div.module.fight_card div[itemprop=performer]")

    {fighter_a_id, fighter_a_result} = parse_main_figter(a)
    {fighter_b_id, fighter_b_result} = parse_main_figter(b)

    [
      {"td", _, [_, _, fight_number]},
      {"td", _, [_, _, method]},
      {"td", _, [_, _, referee]},
      {"td", _, [_, _, round]},
      {"td", _, [_, _, time]}
    ] = Floki.find(html, "div.module.fight_card > div.content.event > div.footer  td")

    [minute, second] = time |> String.trim() |> String.split(":")
    {:ok, time} = Time.new(0, minute |> String.to_integer(), second |> String.to_integer())

    method =
      ~r/[^a-zA-Z ]+/
      |> Regex.replace(method, "", global: true)
      |> String.downcase()
      |> String.trim()
      |> String.split()
      |> List.to_tuple()

    %Fight{
      fighter_a_id: fighter_a_id,
      fighter_b_id: fighter_b_id,
      result: fighter_a_result |> get_result(),
      referee: referee |> String.trim(),
      round: round |> String.trim() |> String.to_integer(),
      method: method,
      time: time
    }
  end

  defp parse_main_figter(fighter) do
    {"div", _,
     [
       _,
       {"h3", [],
        [
          {"a", [{"href", fighter_id}], _}
        ]},
       {"span", _, [result]},
       _
     ]} = fighter

    {fighter_id, result}
  end

  defp get_result("win"), do: :a
  defp get_result("loss"), do: :b
  defp get_result(_), do: :draw
end
