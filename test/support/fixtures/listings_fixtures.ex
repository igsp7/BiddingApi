defmodule BiddingApi.ListingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BiddingApi.Listings` context.
  """

  @doc """
  Generate a listing.
  """
  def listing_fixture(attrs \\ %{}) do
    {:ok, listing} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        condition: "some condition",
        location: "some location",
        name: "some name",
        purchase_date: "some purchase_date"
      })
      |> BiddingApi.Listings.create_listing()

    listing
  end
end
