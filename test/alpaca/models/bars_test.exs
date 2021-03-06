defmodule Alpaca.BarsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Alpaca.Bars

  describe "list/2" do
    test "gets the bars list successfully" do
      use_cassette "bar/list_success" do
        assert {:ok, %{AAPL: bars}} = Bars.list("day", %{symbols: "AAPL"})

        assert length(bars) == 100
      end
    end

    test "gets the bars list unsuccessfully" do
      use_cassette "bar/list_failure" do
        assert {:error,
                %{
                  body: %{code: 40_010_001, message: "at least one symbol is required"},
                  status: 422
                }} = Bars.list("day")
      end
    end
  end
end
