defmodule BiddingApi.BidsTest do
  use BiddingApi.DataCase

  alias BiddingApi.Bids

  describe "bids" do
    alias BiddingApi.Bids.Bid

    import BiddingApi.BidsFixtures

    @invalid_attrs %{ammount: nil, bid_date: nil, email: nil}

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Bids.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Bids.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      valid_attrs = %{ammount: 120.5, bid_date: ~U[2022-06-27 14:17:00Z], email: "some email"}

      assert {:ok, %Bid{} = bid} = Bids.create_bid(valid_attrs)
      assert bid.ammount == 120.5
      assert bid.bid_date == ~U[2022-06-27 14:17:00Z]
      assert bid.email == "some email"
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bids.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      update_attrs = %{ammount: 456.7, bid_date: ~U[2022-06-28 14:17:00Z], email: "some updated email"}

      assert {:ok, %Bid{} = bid} = Bids.update_bid(bid, update_attrs)
      assert bid.ammount == 456.7
      assert bid.bid_date == ~U[2022-06-28 14:17:00Z]
      assert bid.email == "some updated email"
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Bids.update_bid(bid, @invalid_attrs)
      assert bid == Bids.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Bids.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Bids.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Bids.change_bid(bid)
    end
  end
end
