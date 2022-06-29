defmodule BiddingApiWeb.AuctionDetailsView do
  use BiddingApiWeb, :view
  alias BiddingApiWeb.AuctionDetailsView

  def render("index.json", %{auctions: auctions}) do
    %{data: render_many(auctions, AuctionDetailsView, "auction.json")}
  end

  def render("show.json", %{auction: auction}) do
    %{data: render_one(auction, AuctionDetailsView, "auction.json")}
  end

  def render("auction.json", %{auction_details: auction_details}) do
    %{
      id: auction_details.auction.id,
      title: auction_details.auction.title,
      email: auction_details.auction.email,
      description: auction_details.auction.description,
      status: auction_details.auction.status,
      starting_price: :erlang.float_to_binary(auction_details.auction.starting_price,[ decimals: 2]),
      buy_now_price: :erlang.float_to_binary(auction_details.auction.buy_now_price,[ decimals: 2]),
      start_date: auction_details.auction.start_date,
      end_date: auction_details.auction.end_date,
      listing_id: auction_details.auction.listing_id,
      listing_name: auction_details.listing_name,
      highest_bid_ammount: :erlang.float_to_binary(auction_details.highest_bid_ammount,[ decimals: 2]),
      highest_bid_email: auction_details.highest_bid_email,
      highest_bid_date: auction_details.highest_bid_date
    }
  end
end
