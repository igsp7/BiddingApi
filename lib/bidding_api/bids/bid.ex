defmodule BiddingApi.Bids.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  alias BiddingApi.Bids.BidValidator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bids" do
    field :ammount, :float
    field :bid_date, :utc_datetime
    field :email, :string
    belongs_to :auction, BiddingApi.Auctions.Auction
    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:email, :ammount, :bid_date, :auction_id])
    |> validate_required([:email, :ammount, :auction_id])
    |> BidValidator.validate_auction_status
    |> BidValidator.validate_ammount
  end


end
