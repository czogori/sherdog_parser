defmodule SherdogParserTest do
  use ExUnit.Case
  doctest SherdogParser

  setup_all do
    {:ok, html} = File.read("./test/fixtures/mamed_khalidov_page.html")
    {:ok, fighter_page: html}
  end

  test "parse a fighter", state do
    fighter = SherdogParser.fighter(state.fighter_page)

    assert "Mamed Khalidov" == fighter.name
    assert ~D[1980-07-17] == fighter.birthdate
    assert {"Poland", "Olsztyn"} == fighter.birthplace
    assert 183 == fighter.height
    assert 84 == fighter.weight
    assert 41 == fighter.fights |> Enum.count()
  end

  test "find ids of fighters", state do
    count =
      state.fighter_page
      |> SherdogParser.fighter_ids()
      |> Enum.count()

    assert 55 == count
  end

  test "fighter without a birthdate" do
    {:ok, html} = File.read("./test/fixtures/fighter_without_birthdate.html")
    fighter = SherdogParser.fighter(html)

    refute fighter.birthdate
  end
end
