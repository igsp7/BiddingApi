defmodule BiddingApiWeb.AuctionController do
  use BiddingApiWeb, :controller

  alias BiddingApi.Auctions
  alias BiddingApi.Auctions.Auction

  action_fallback BiddingApiWeb.FallbackController

  def index(conn, _params) do
    auctions = Auctions.list_auctions()
    render(conn, "index.json", auctions: auctions)
  end

  def create(conn, %{"auction" => auction_params}) do
    with {:ok, %Auction{} = auction} <- Auctions.create_auction(auction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.auction_path(conn, :show, auction))
      |> render("show.json", auction: auction)
    end
  end

  def show(conn, %{"id" => id}) do
    auction = Auctions.get_auction!(id)
    render(conn, "show.json", auction: auction)
  end

  def update(conn, %{"id" => id, "auction" => auction_params}) do
    auction = Auctions.get_auction!(id)

    with {:ok, %Auction{} = auction} <- Auctions.update_auction(auction, auction_params) do
      render(conn, "show.json", auction: auction)
    end
  end

  def delete(conn, %{"id" => id}) do
    auction = Auctions.get_auction!(id)

    with {:ok, %Auction{}} <- Auctions.delete_auction(auction) do
      send_resp(conn, :no_content, "")
    end
  end

  def start(conn, %{"id" => id}) do
    auction = Auctions.get_auction!(id)

    with {:ok, %Auction{} = auction} <- Auctions.start_auction(auction) do
      render(conn, "show.json", auction: auction)
    end
  end

  def stop(conn, %{"id" => id}) do
    auction = Auctions.get_auction!(id)

    with {:ok, %Auction{} = auction} <- Auctions.stop_auction(auction) do
      render(conn, "show.json", auction: auction)
    end
  end
end
