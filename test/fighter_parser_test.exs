defmodule FighterParserTest do
  use ExUnit.Case
  alias SherdogParser.Fight

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
    assert 42 == fighter.fights |> Enum.count()
  end

  test "the first fight", state do
    fighter = SherdogParser.fighter(state.fighter_page)

    expected = %Fight{
      fighter_a_id: "",
      fighter_a_name: "Mamed Khalidov",
      fighter_b_id: "/fighter/Nerijus-Valiukevicius-8735",
      fighter_b_name: "Nerijus Valiukevicius",
      method: {"TKO", "Punches"},
      result: :fighter_b,
      round: 1,
      time: ~T[00:04:49],
      referee: "N/A",
      event_id: "/events/Shooto-Lithuania-Bushido-King-2354",
      event_name: "Shooto Lithuania - Bushido King",
      event_date: ~D[2004-05-18]
    }

    assert expected == Enum.at(fighter.fights, 0)
  end

  test "fighter without a birthdate" do
    {:ok, html} = File.read("./test/fixtures/fighter_without_birthdate.html")
    fighter = SherdogParser.fighter(html)

    refute fighter.birthdate
  end
end
