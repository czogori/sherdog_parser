defmodule SherdogFightTest do
  use ExUnit.Case
  alias SherdogParser.Fight, as: F

  test "end of fight methods" do
    datas = [
      %{
        actual: "TKO (Submission to Punches)",
        expected: {"TKO", "Submission to Punches"}
      },
      %{
        actual: "Submission (Rear-Naked Choke)",
        expected: {"Submission", "Rear-Naked Choke"}
      }
    ]
    for data <- datas do
      assert data.expected == F.method(data.actual)
    end
  end
end
