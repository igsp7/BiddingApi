defmodule BiddingApi.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :ammount, :float
      add :bid_date, :utc_datetime
      add :auction_id, references(:auctions, column: :id, type: :binary_id), null: false

      timestamps()
    end
  end
end
