defmodule SherdogParser.Fight do
  @moduledoc """
  Documentation for SherdogParser.Fight.
  """
  use TypedStruct

  @typedoc "A fight"
  typedstruct do
    field(:fighter_a_id, String.t(), enforce: true)
    field(:fighter_a_name, String.t(), enforce: true)
    field(:fighter_b_id, String.t(), enforce: true)
    field(:fighter_b_name, String.t(), enforce: true)
    field(:result, atom(), enforce: true)
    field(:method, String.t(), enforce: true)
    field(:round, non_neg_integer())
    field(:referee, String.t())
    field(:time, Time.t())
    field(:event_id, String.t())
    field(:event_name, String.t())
    field(:event_date, Date.t())
  end

  def method("Draw"), do: ""

  def method(m) do
    [_, major, minor] =
      ~r/(.*?)\((.*?)\)/
      |> Regex.run(m, global: true)

    {String.trim(major), minor}
  end

  def get_result("win"), do: :a
  def get_result("loss"), do: :b
  def get_result("draw"), do: :draw

  def parse_time(time) do
    [minute, second] = time |> String.trim() |> String.split(":")
    {:ok, time} = Time.new(0, minute |> String.to_integer(), second |> String.to_integer())
    time
  end
end
