defmodule BiddingApiWeb.BidView do
  use BiddingApiWeb, :view
  alias BiddingApiWeb.BidView

  def render("index.json", %{bids: bids}) do
    %{data: render_many(bids, BidView, "bid.json")}
  end

  def render("show.json", %{bid: bid}) do
    %{data: render_one(bid, BidView, "bid.json")}
  end

  def render("bid.json", %{bid: bid}) do
    %{
      id: bid.id,
      email: bid.email,
      ammount: :erlang.float_to_binary(bid.ammount,[ decimals: 2]),
      bid_date: bid.bid_date,
      auction_id: bid.auction_id
    }
  end
end
