defmodule BiddingApi.AuctionsTest do
  use BiddingApi.DataCase

  alias BiddingApi.Auctions

  describe "auctions" do
    alias BiddingApi.Auctions.Auction

    import BiddingApi.AuctionsFixtures

    @invalid_attrs %{buy_now_price: nil, description: nil, email: nil, end_date: nil, start_date: nil, starting_price: nil, status: nil, title: nil}

    test "list_auctions/0 returns all auctions" do
      auction = auction_fixture()
      assert Auctions.list_auctions() == [auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      auction = auction_fixture()
      assert Auctions.get_auction!(auction.id) == auction
    end

    test "create_auction/1 with valid data creates a auction" do
      valid_attrs = %{buy_now_price: 120.5, description: "some description", email: "some email", end_date: ~U[2022-06-27 13:12:00Z], start_date: ~U[2022-06-27 13:12:00Z], starting_price: 120.5, status: "some status", title: "some title"}

      assert {:ok, %Auction{} = auction} = Auctions.create_auction(valid_attrs)
      assert auction.buy_now_price == 120.5
      assert auction.description == "some description"
      assert auction.email == "some email"
      assert auction.end_date == ~U[2022-06-27 13:12:00Z]
      assert auction.start_date == ~U[2022-06-27 13:12:00Z]
      assert auction.starting_price == 120.5
      assert auction.status == "some status"
      assert auction.title == "some title"
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auctions.create_auction(@invalid_attrs)
    end

    test "update_auction/2 with valid data updates the auction" do
      auction = auction_fixture()
      update_attrs = %{buy_now_price: 456.7, description: "some updated description", email: "some updated email", end_date: ~U[2022-06-28 13:12:00Z], start_date: ~U[2022-06-28 13:12:00Z], starting_price: 456.7, status: "some updated status", title: "some updated title"}

      assert {:ok, %Auction{} = auction} = Auctions.update_auction(auction, update_attrs)
      assert auction.buy_now_price == 456.7
      assert auction.description == "some updated description"
      assert auction.email == "some updated email"
      assert auction.end_date == ~U[2022-06-28 13:12:00Z]
      assert auction.start_date == ~U[2022-06-28 13:12:00Z]
      assert auction.starting_price == 456.7
      assert auction.status == "some updated status"
      assert auction.title == "some updated title"
    end

    test "update_auction/2 with invalid data returns error changeset" do
      auction = auction_fixture()
      assert {:error, %Ecto.Changeset{}} = Auctions.update_auction(auction, @invalid_attrs)
      assert auction == Auctions.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{}} = Auctions.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> Auctions.get_auction!(auction.id) end
    end

    test "change_auction/1 returns a auction changeset" do
      auction = auction_fixture()
      assert %Ecto.Changeset{} = Auctions.change_auction(auction)
    end
  end
end
