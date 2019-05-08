defmodule SherdogParserTest do
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

  test "fighter without a birthdate" do
    {:ok, html} = File.read("./test/fixtures/fighter_without_birthdate.html")
    fighter = SherdogParser.fighter(html)

    refute fighter.birthdate
  end

  test "organization page" do
    {:ok, html} = File.read("./test/fixtures/organization.html")

    organization = SherdogParser.organization(html)

    assert "Konfrontacja Sztuk Walki" == organization.name
    assert 52 == Enum.count(organization.event_urls)
  end

  test "event ksw 44" do
    {:ok, html} = File.read("./test/fixtures/event-ksw-44.html")
    id = "/events/KSW-44-The-Game-67083"
    event = SherdogParser.event(html)

    assert "KSW 44" == event.title
    assert "The Game" == event.subtitle
    assert "/organizations/Konfrontacja-Sztuk-Walki-668" == event.organization_url
    assert ~D[2018-06-09] == event.date
    assert "Ergo Arena, Gdansk, Poland" == event.location

    assert %Fight{
             fighter_a_id: "/fighter/Karol-Bedorf-25819",
             fighter_b_id: "/fighter/Mariusz-Pudzianowski-57308",
             result: :a,
             method: {"submission", "kimura"},
             round: 1,
             time: ~T[00:01:51],
             date: ~D[2018-06-09],
             referee: "Marc",
           } == event.main_fight
  end
end
