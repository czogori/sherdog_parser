defmodule SherdogParserTest do
  use ExUnit.Case
  doctest SherdogParser

  setup_all do
    {:ok, html} = File.read("./test/fixtures/mamed_khalidov_page.html")
    {:ok, fighter_page: html}
  end

  test "parse a fighter", state do
    fighter = SherdogParser.parse_fighter(state.fighter_page)
    assert "Mamed Khalidov" == fighter.name
  end

  test "find ids of fighters", state do
    count = SherdogParser.find_fighters_id(state.fighter_page) |> Enum.count()
    assert 55 == count
  end
end
