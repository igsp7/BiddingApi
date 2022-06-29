defmodule BiddingApi.Auctions do
  @moduledoc """
  The Auctions context.
  """

  import Ecto.Query, warn: false
  alias BiddingApi.Repo

  alias BiddingApi.Auctions.Auction
  alias BiddingApi.Bids.Bid

  @doc """
  Returns the list of auctions.

  ## Examples

      iex> list_auctions()
      [%Auction{}, ...]

  """
  def list_auctions do
    Repo.all(Auction)
  end

  @doc """
  Returns the list of auctions with details. Details include the listing name, the highest bid ammount,
  the highest bid emaiil and the highest bid date.

  ## Examples

      iex> list_auctions_with_details()
      [%AuctionDetails{}, ...]

  """
  def list_auctions_with_details do
    max_ammount_query = from bid in Bid,
      select: %{ammount: max(bid.ammount), auction_id: bid.auction_id},
      group_by: bid.auction_id

    bid_table_query = from bid in Bid,
      select: %{ammount: bid.ammount, auction_id: bid.auction_id, email: bid.email, bid_date: bid.bid_date},
      join: max_bid in subquery(max_ammount_query),
      on: bid.auction_id == max_bid.auction_id and bid.ammount == max_bid.ammount

    auctions_with_listing_details_query = from auction in Auction,
      join: listing in assoc(auction, :listing),
      join: bid in subquery(bid_table_query),
      on: bid.auction_id == auction.id,
      select: %{auction: auction, listing_name: listing.name, highest_bid_ammount: bid.ammount, highest_bid_email: bid.email, highest_bid_date: bid.bid_date}

    Repo.all(auctions_with_listing_details_query)
  end

  @doc """
  Gets a single auction with details. Details include the listing name and the highest bid.

  Raises `Ecto.NoResultsError` if the Auction does not exist.

  ## Examples

      iex> get_auction_with_details!(123)
      %Auction{}

      iex> get_auction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auction_with_details!(id) do
    auction_with_listing_details_query = from auction in Auction,
      where: auction.id == ^id,
      join: listing in assoc(auction, :listing),
      join: bid in assoc(auction, :bid),
      order_by: [desc: bid.ammount],
      limit: 1,
      select: %{auction: auction, listing_name: listing.name, highest_bid_ammount: bid.ammount, highest_bid_email: bid.email, highest_bid_date: bid.bid_date}
    Repo.one!(auction_with_listing_details_query)
  end

  @doc """
  Gets a single auction.

  Raises `Ecto.NoResultsError` if the Auction does not exist.

  ## Examples

      iex> get_auction!(123)
      %Auction{}

      iex> get_auction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auction!(id), do: Repo.get!(Auction, id)

  @doc """
  Gets a single auction.

  Raises `Ecto.NoResultsError` if the Auction does not exist.

  ## Examples

      iex> get_auction!(123)
      %Auction{}

      iex> get_auction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auction_buy_now_price!(id), do: Repo.get!(Auction, id).buy_now_price

  @doc """
  Creates an auction.

  ## Examples

      iex> create_auction(%{field: value})
      {:ok, %Auction{}}

      iex> create_auction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auction(attrs \\ %{}) do
    %Auction{}
    |> Auction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an auction.

  ## Examples

      iex> update_auction(auction, %{field: new_value})
      {:ok, %Auction{}}

      iex> update_auction(auction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auction(%Auction{} = auction, attrs) do
    auction
    |> Auction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Starts an auction by setting the auction status to ONGOING and the start_date to the current datetime.

  ## Examples

      iex> start_auction(auction})
      {:ok, %Auction{}}
  """
  def start_auction(%Auction{} = auction) do
    auction
    |> Auction.changeset(%{status: "ONGOING", start_date: DateTime.utc_now()})
    |> Repo.update()
  end

  @doc """
  Stops an auction by setting the auction status to CLOSED and the end_date to the current datetime.
  Takes as arguments either an Auction struct or an Auction id

  ## Examples

      iex> start_auction(auction)
      {:ok, %Auction{}}
  """
  def stop_auction(%Auction{} = auction) do
    auction
    |> Auction.changeset(%{status: "CLOSED", end_date: DateTime.utc_now()})
    |> Repo.update()
  end

  @doc """
  Stops an auction by setting the auction status to CLOSED and the end_date to the current datetime.
  Takes as arguments either an Auction struct or an Auction id

  ## Examples

      iex> start_auction(auction)
      {:ok, %Auction{}}
  """
  def stop_auction(id) do
    get_auction!(id)
    |> Auction.changeset(%{status: "CLOSED", end_date: DateTime.utc_now()})
    |> Repo.update()
  end

  @doc """
  Deletes an auction.

  ## Examples

      iex> delete_auction(auction)
      {:ok, %Auction{}}

      iex> delete_auction(auction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auction(%Auction{} = auction) do
    Repo.delete(auction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auction changes.

  ## Examples

      iex> change_auction(auction)
      %Ecto.Changeset{data: %Auction{}}

  """
  def change_auction(%Auction{} = auction, attrs \\ %{}) do
    Auction.changeset(auction, attrs)
  end

  @doc """
  Checks if an auction is ongoing

  ## Examples

      iex> status_ongoing?(id)
      true

  """
  def status_ongoing?(id) do
    auction = get_auction!(id)
    auction.status == "ONGOING"
  end
end
