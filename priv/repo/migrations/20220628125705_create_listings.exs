defmodule BiddingApi.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :brand, :string
      add :purchase_date, :utc_datetime
      add :condition, :string
      add :location, :string

      timestamps()
    end
  end
end
