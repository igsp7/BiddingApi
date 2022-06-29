defmodule BiddingApi.AuctionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BiddingApi.Auctions` context.
  """

  @doc """
  Generate a auction.
  """
  def auction_fixture(attrs \\ %{}) do
    {:ok, auction} =
      attrs
      |> Enum.into(%{
        buy_now_price: 120.5,
        description: "some description",
        email: "some email",
        end_date: ~U[2022-06-27 13:12:00Z],
        start_date: ~U[2022-06-27 13:12:00Z],
        starting_price: 120.5,
        status: "some status",
        title: "some title"
      })
      |> BiddingApi.Auctions.create_auction()

    auction
  end
end
