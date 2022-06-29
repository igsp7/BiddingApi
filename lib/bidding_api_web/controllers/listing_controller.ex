defmodule BiddingApiWeb.ListingController do
  use BiddingApiWeb, :controller

  alias BiddingApi.Listings
  alias BiddingApi.Listings.Listing

  action_fallback BiddingApiWeb.FallbackController

  def index(conn, _params) do
    listings = Listings.list_listings()
    render(conn, "index.json", listings: listings)
  end

  def create(conn, %{"listing" => listing_params}) do
    with {:ok, %Listing{} = listing} <- Listings.create_listing(listing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.listing_path(conn, :show, listing))
      |> render("show.json", listing: listing)
    end
  end

  def show(conn, %{"id" => id}) do
    listing = Listings.get_listing!(id)
    render(conn, "show.json", listing: listing)
  end

  def update(conn, %{"id" => id, "listing" => listing_params}) do
    listing = Listings.get_listing!(id)

    with {:ok, %Listing{} = listing} <- Listings.update_listing(listing, listing_params) do
      render(conn, "show.json", listing: listing)
    end
  end

  def delete(conn, %{"id" => id}) do
    listing = Listings.get_listing!(id)

    with {:ok, %Listing{}} <- Listings.delete_listing(listing) do
      send_resp(conn, :no_content, "")
    end
  end
end
