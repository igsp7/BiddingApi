defmodule BiddingApi.Bids do
  @moduledoc """
  The Bids context.
  """

  import Ecto.Query, warn: false
  alias BiddingApi.Repo

  alias BiddingApi.Bids.Bid
  alias BiddingApi.Auctions

  @doc """
  Returns the list of bids.

  ## Examples

      iex> list_bids()
      [%Bid{}, ...]

  """
  def list_bids do
    Repo.all(Bid)
  end

  @doc """
  Gets a single bid.

  Raises `Ecto.NoResultsError` if the Bid does not exist.

  ## Examples

      iex> get_bid!(123)
      %Bid{}

      iex> get_bid!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bid!(id), do: Repo.get!(Bid, id)

  @doc """
  Creates a bid and puts the current datetime in bid_date.
  If the bid ammount is highest than the buy now price of the auction then the auction is closed.

  ## Examples

      iex> create_bid(%{field: value})
      {:ok, %Bid{}}

      iex> create_bid(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bid(attrs \\ %{}) do
    created_bid = %Bid{}
    |> Bid.changeset(Map.put(attrs, "bid_date", DateTime.utc_now()))
    |> Repo.insert()

    if bid_buy_now?(created_bid) do
      Auctions.stop_auction(attrs["auction_id"])
    end

    created_bid
  end

  @doc """
  Updates a bid.

  ## Examples

      iex> update_bid(bid, %{field: new_value})
      {:ok, %Bid{}}

      iex> update_bid(bid, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bid(%Bid{} = bid, attrs) do
    bid
    |> Bid.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bid.

  ## Examples

      iex> delete_bid(bid)
      {:ok, %Bid{}}

      iex> delete_bid(bid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bid(%Bid{} = bid) do
    Repo.delete(bid)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bid changes.

  ## Examples

      iex> change_bid(bid)
      %Ecto.Changeset{data: %Bid{}}

  """
  def change_bid(%Bid{} = bid, attrs \\ %{}) do
    Bid.changeset(bid, attrs)
  end

  @doc """
  Checks if the created bid 's ammount is higher than the auction buy now price

  ## Examples

      iex> bid_buy_now?(changeset)
      true

  """
  defp bid_buy_now?({:error, _}), do: false
  defp bid_buy_now?({:ok, %Bid{ammount: bid_ammount, auction_id: auction_id}})do
    auction_id
    |> Auctions.get_auction_buy_now_price!
    |> greater?(bid_ammount)
  end

  @doc """
  Checks if the bid is the highest bid for a given auction.

  ## Examples

      iex> highest_bid?(bid_ammount, auction_id)
      true

  """
  def highest_bid?(bid_ammount, auction_id) do
    from(bid in Bid,
      where: bid.auction_id == ^auction_id,
      order_by: [desc: bid.ammount],
      limit: 1,
      select: bid.ammount)
    |> Repo.one
    |> greater?(bid_ammount)
  end

  defp greater?(nil, _), do: true
  defp greater?(highest_bid, bid_ammount), do: bid_ammount > highest_bid
end
