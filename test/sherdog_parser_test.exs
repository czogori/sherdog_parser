defmodule SherdogParserTest do
  use ExUnit.Case
  doctest SherdogParser

  test "parse a fighter" do
    fighters = [
      {"fighter/Mamed-Khalidov-10489", "Mamed Khalidov"},
      {"fighter/Borys-Mankowski-35714", "Borys Mankowski"}
    ]

    for {fighter_id, name} <- fighters do
      html = get_fighter_html(fighter_id)

      fighter = SherdogParser.parse_fighter(html)
      assert fighter.name == name
    end
  end

  defp get_fighter_html(id) do
    url = "http://www.sherdog.com/" <> id

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts(reason)
    end
  end
end
