defmodule BiddingApiWeb.ListingView do
  use BiddingApiWeb, :view
  alias BiddingApiWeb.ListingView

  def render("index.json", %{listings: listings}) do
    %{data: render_many(listings, ListingView, "listing.json")}
  end

  def render("show.json", %{listing: listing}) do
    %{data: render_one(listing, ListingView, "listing.json")}
  end

  def render("listing.json", %{listing: listing}) do
    %{
      id: listing.id,
      name: listing.name,
      brand: listing.brand,
      purchase_date: listing.purchase_date,
      condition: listing.condition,
      location: listing.location
    }
  end
end
