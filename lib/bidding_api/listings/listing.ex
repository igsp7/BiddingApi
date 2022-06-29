defmodule BiddingApi.Listings.Listing do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "listings" do
    field :brand, :string
    field :condition, :string
    field :location, :string
    field :name, :string
    field :purchase_date, :utc_datetime
    has_one :auction, BiddingApi.Auctions.Auction

    timestamps()
  end

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, [:name, :brand, :purchase_date, :condition, :location])
    |> validate_required([:name, :brand, :purchase_date, :condition, :location])
  end
end
