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
end
