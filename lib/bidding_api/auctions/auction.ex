defmodule BiddingApi.Auctions.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  alias BiddingApi.Auctions.AuctionValidator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "auctions" do
    field :buy_now_price, :float
    field :description, :string
    field :email, :string
    field :end_date, :utc_datetime
    field :start_date, :utc_datetime
    field :starting_price, :float
    field :status, :string
    field :title, :string
    belongs_to :listing, BiddingApi.Listings.Listing
    has_many :bid, BiddingApi.Bids.Bid

    timestamps()
  end

  @doc false
  def changeset(auction, attrs = %{status: "ONGOING", start_date: _start_date}) do
    auction
    |> cast(attrs, [:status, :start_date])
    |> AuctionValidator.validate_status_not_ongoing(auction)
  end

  @doc false
  def changeset(auction, attrs = %{status: "CLOSED", end_date: _start_date}) do
    auction
    |> cast(attrs, [:status, :end_date])
    |> AuctionValidator.validate_status_ongoing(auction)
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:title, :email, :description, :status, :starting_price, :buy_now_price, :start_date, :end_date, :listing_id])
    |> validate_required([:title, :email, :description, :status, :starting_price, :buy_now_price, :start_date, :end_date, :listing_id])
    |> validate_inclusion(:status, ["PENDING","ONGOING", "CLOSED"])
  end


end
