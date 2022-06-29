defmodule BiddingApiWeb.BidController do
  use BiddingApiWeb, :controller

  alias BiddingApi.Bids
  alias BiddingApi.Bids.Bid

  action_fallback BiddingApiWeb.FallbackController

  def index(conn, _params) do
    bids = Bids.list_bids()
    render(conn, "index.json", bids: bids)
  end

  def create(conn, %{"bid" => bid_params}) do
    with {:ok, %Bid{} = bid} <- Bids.create_bid(bid_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bid_path(conn, :show, bid))
      |> render("show.json", bid: bid)
    end
  end

  def show(conn, %{"id" => id}) do
    bid = Bids.get_bid!(id)
    render(conn, "show.json", bid: bid)
  end

  def update(conn, %{"id" => id, "bid" => bid_params}) do
    bid = Bids.get_bid!(id)

    with {:ok, %Bid{} = bid} <- Bids.update_bid(bid, bid_params) do
      render(conn, "show.json", bid: bid)
    end
  end

  def delete(conn, %{"id" => id}) do
    bid = Bids.get_bid!(id)

    with {:ok, %Bid{}} <- Bids.delete_bid(bid) do
      send_resp(conn, :no_content, "")
    end
  end
end
