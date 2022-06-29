defmodule BiddingApi.Bids.BidValidator do
  import Ecto.Changeset

  alias BiddingApi.Bids
  alias BiddingApi.Auctions

  def validate_ammount(changeset) do
    ammount_value = get_field(changeset, :ammount)
    auction_id_value = get_field(changeset, :auction_id)
    if Bids.highest_bid?(ammount_value, auction_id_value) do
      changeset
    else
      add_error(changeset, :ammount, "The bid ammount must be higher than the current highest bid")
    end
  end

  def validate_auction_status(changeset) do
    is_status_ongoing = get_field(changeset, :auction_id)
    |>Auctions.status_ongoing?

    if is_status_ongoing do
      changeset
    else
      add_error(changeset, :auction_id, "The auction is not ongoing")
    end
  end
end
