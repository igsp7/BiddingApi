defmodule BiddingApi.BidsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BiddingApi.Bids` context.
  """

  @doc """
  Generate a bid.
  """
  def bid_fixture(attrs \\ %{}) do
    {:ok, bid} =
      attrs
      |> Enum.into(%{
        ammount: 120.5,
        bid_date: ~U[2022-06-27 14:17:00Z],
        email: "some email"
      })
      |> BiddingApi.Bids.create_bid()

    bid
  end
end
