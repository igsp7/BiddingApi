defmodule BiddingApi.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, column: :id, type: :binary_id), null: false
      add :title, :string
      add :email, :string
      add :description, :string
      add :status, :string
      add :starting_price, :float
      add :buy_now_price, :float
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime

      timestamps()
    end

  end
end
