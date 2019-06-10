defmodule EventTest do
  use ExUnit.Case
  alias SherdogParser.Fight

  doctest SherdogParser

  setup_all do
    {:ok, html} = File.read("./test/fixtures/event-ksw-44.html")
    event = SherdogParser.event(html)
    {:ok, event: event}
  end

  test "event ksw 44", state do
    event = state.event

    assert "KSW 44" == event.title
    assert "The Game" == event.subtitle
    assert "/organizations/Konfrontacja-Sztuk-Walki-668" == event.organization_url
    assert ~D[2018-06-09] == event.date
    assert "Ergo Arena, Gdansk, Poland" == event.location
  end

  test "main fight", state do
    event = state.event

    assert %Fight{
             fighter_a_id: "/fighter/Karol-Bedorf-25819",
             fighter_a_name: "Karol Bedorf",
             fighter_b_id: "/fighter/Mariusz-Pudzianowski-57308",
             fighter_b_name: "Mariusz Pudzianowski",
             result: :a,
             method: {"submission", "kimura"},
             round: 1,
             time: ~T[00:01:51],
             date: ~D[2018-06-09],
             referee: "Marc"
           } == event.main_fight
  end

  test "number fights", state do
    event = state.event

    assert 9 == Enum.count(event.fights)
  end

  test "first fight", state do
    event = state.event

    assert %Fight{
             fighter_a_id: "/fighter/Sebastian-Przybysz-218519",
             fighter_a_name: "Sebastian Przybysz",
             fighter_b_id: "/fighter/Dawid-Gralka-183925",
             fighter_b_name: "Dawid Gralka",
             result: :a,
             method: "KO (Punch)",
             round: 1,
             time: ~T[00:01:48],
             date: ~D[2018-06-09],
             referee: "Łukasz Bosacki"
           } == List.first(event.fights)
  end

  test "last fight should be main event fight", state do
    event = state.event

    assert event.main_fight == List.last(event.fights)
  end
end
