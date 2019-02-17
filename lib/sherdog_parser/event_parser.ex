defmodule SherdogParser.EventParser do
  @moduledoc """
  Documentation for SherdogParser.EventParser.
  """

  alias SherdogParser.Event
  use Timex

  def parse(html) do
    {title, subtitle} = parse_title(html)
    organization_url = parse_organization_url(html)
    date = parse_date(html)
    location = parse_location(html)

    Event.new(title, date, location)
    |> struct(subtitle: subtitle)
    |> struct(organization_url: organization_url)
  end

  defp parse_title(html) do
    [{"span", [{"itemprop", "name"}], [title, {"br", [], []}, subtitle]}] =
      Floki.find(html, "div.header > div.section_title > h1 > span")

    {title, subtitle}
  end

  defp parse_organization_url(html) do
    [{"a",[_,{"href", url}],_}] = Floki.find(html, "div.header > div.section_title > h2 > div > a")
    url
  end

  defp parse_date(html) do
    [
      {_, _, [{_,[_,{"content", date}],_},_]}] =
        Floki.find(html, "div.header > div.info > div.authors_info > span.date")

    date
    |> Timex.parse!("{ISO:Extended}")
    |> DateTime.to_date()
  end

  defp parse_location(html) do
    [{_, _,[_,{_, _,[location]}]}] =
      Floki.find(html, "div.header > div.info > div.authors_info > span.author")

    location
  end
end
