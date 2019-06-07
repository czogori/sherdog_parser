defmodule SherdogParser.OrganizationParser do
  @moduledoc """
  Documentation for SherdogParser.OrganiaztionParser.
  """
  alias SherdogParser.{Event, Organization}

  def parse(html) do
    %Organization{
      name: parse_name(html),
      event_urls: parse_event_urls(html)
    }
  end

  defp parse_name(html) do
    [{"h2", _, [name]}] = Floki.find(html, ".module.bio_organization > div.module_header > h2")

    name
  end

  defp parse_event_urls(html) do
    html
    |> Floki.find("tr[itemtype=\"http://schema.org/Event\"")
    |> Enum.map(fn i -> parse_event_url(i) end)
  end

  def parse_event_url(tr) do
    case tr do
      {"tr", _, [_, {"td", [], [{"a", [_, {"href", url}], _}]}, _]} ->
        url

      _ ->
        :err
    end
  end

  def parse_date(year, month, day)
      when is_bitstring(year) and is_bitstring(month) and is_bitstring(year) do
    Date.from_erl!({String.to_integer(year), month(month), String.to_integer(day)})
  end

  defp month("Jan"), do: 1
  defp month("Feb"), do: 2
  defp month("Mar"), do: 3
  defp month("Apr"), do: 4
  defp month("May"), do: 5
  defp month("Jun"), do: 6
  defp month("Jul"), do: 7
  defp month("Aug"), do: 8
  defp month("Sep"), do: 9
  defp month("Nov"), do: 10
  defp month("Dec"), do: 11
  defp month("Oct"), do: 12
end
