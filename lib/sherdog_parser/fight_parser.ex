# defmodule SherdogParser.FightParser do
#   @moduledoc """
#   Documentation for SherdogParser.FightParser.
#   """
#   alias SherdogParser.{Event, Fight, FighterUrl}

#   def parse(tr) do
#     {"tr", _, [result, fighter, event, td_method_referee, round, date]} = tr

#     {method, referee} = parse_method_referee(td_method_referee)

#     %Fight{
#       fighter_a_id
#     }
#     Fight.new(
#       parse_fighter(fighter),
#       parse_result(result),
#       method,
#       parse_round(round),
#       parse_date(date),
#       referee,
#       parse_event(event)
#     )
#   end

#   defp parse_fighter(td) do
#     {"td", _, [{"a", [{"href", fighter_link}], [_name]}]} = td

#     FighterUrl.new(fighter_link)
#   end

#   defp parse_result(td) do
#     {"td", _, [{"span", _, [result]}]} = td

#     result
#   end

#   defp parse_event(td) do
#     {"td", [],
#      [
#        {"a", [{"href", link}], [name]},
#        {"br", [], []},
#        {"span", [{"class", "sub_line"}], [date]}
#      ]} = td

#     Event.new(name, date, link)
#   end

#   defp parse_method_referee(td) do
#     {"td", [],
#      [
#        method,
#        {"br", [], []},
#        {"span", [{"class", "sub_line"}], [referee]}
#      ]} = td

#     {method, referee}
#   end

#   defp parse_round(td) do
#     {"td", _, [round]} = td

#     round
#   end

#   defp parse_date(td) do
#     {"td", _, [date]} = td

#     date
#   end
# end
