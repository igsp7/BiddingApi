defmodule BiddingApiWeb.AuctionView do
  use BiddingApiWeb, :view
  alias BiddingApiWeb.AuctionView

  def render("index.json", %{auctions: auctions}) do
    %{data: render_many(auctions, AuctionView, "auction.json")}
  end

  def render("show.json", %{auction: auction}) do
    %{data: render_one(auction, AuctionView, "auction.json")}
  end

  def render("auction.json", %{auction: auction}) do
    %{
      id: auction.id,
      title: auction.title,
      email: auction.email,
      description: auction.description,
      status: auction.status,
      starting_price: :erlang.float_to_binary(auction.starting_price,[ decimals: 2]),
      buy_now_price: :erlang.float_to_binary(auction.buy_now_price,[ decimals: 2]),
      start_date: auction.start_date,
      end_date: auction.end_date,
      listing_id: auction.listing_id
    }
  end
end
