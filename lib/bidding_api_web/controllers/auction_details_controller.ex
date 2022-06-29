defmodule BiddingApiWeb.AuctionDetailsController do
  use BiddingApiWeb, :controller

  alias BiddingApi.Auctions

  action_fallback BiddingApiWeb.FallbackController

  def index(conn, _params) do
    auctions = Auctions.list_auctions_with_details()
    render(conn, "index.json", auctions: auctions)
  end

  def show(conn, %{"id" => id}) do
    auction = Auctions.get_auction_with_details!(id)
    render(conn, "show.json", auction: auction)
  end
end
