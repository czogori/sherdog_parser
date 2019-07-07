defmodule SherdogOrganizationTest do
  use ExUnit.Case

  doctest SherdogParser

  setup_all do
    {:ok, html} = File.read("./test/fixtures/organization.html")
    {:ok, html: html}
  end

  test "organization page", state do
    organization = SherdogParser.organization(state.html)

    assert "Konfrontacja Sztuk Walki" == organization.name
    assert 52 == Enum.count(organization.event_urls)
  end
end
