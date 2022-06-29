defmodule BiddingApi.Auctions.AuctionValidator do
  import Ecto.Changeset

  def validate_status_ongoing(changeset, auction)do
    if auction.status == "ONGOING" do
      changeset
    else
      add_error(changeset, :status, "The auction is not ongoing")
    end
  end

  def validate_status_not_ongoing(changeset, auction) do
    if auction.status == "ONGOING" do
      add_error(changeset, :status, "The auction is already ongoing")
    else
      changeset
    end
  end
end
