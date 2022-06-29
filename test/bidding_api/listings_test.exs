defmodule BiddingApi.ListingsTest do
  use BiddingApi.DataCase

  alias BiddingApi.Listings

  describe "listings" do
    alias BiddingApi.Listings.Listing

    import BiddingApi.ListingsFixtures

    @invalid_attrs %{brand: nil, condition: nil, location: nil, name: nil, purchase_date: nil}

    test "list_listings/0 returns all listings" do
      listing = listing_fixture()
      assert Listings.list_listings() == [listing]
    end

    test "get_listing!/1 returns the listing with given id" do
      listing = listing_fixture()
      assert Listings.get_listing!(listing.id) == listing
    end

    test "create_listing/1 with valid data creates a listing" do
      valid_attrs = %{brand: "some brand", condition: "some condition", location: "some location", name: "some name", purchase_date: "some purchase_date"}

      assert {:ok, %Listing{} = listing} = Listings.create_listing(valid_attrs)
      assert listing.brand == "some brand"
      assert listing.condition == "some condition"
      assert listing.location == "some location"
      assert listing.name == "some name"
      assert listing.purchase_date == "some purchase_date"
    end

    test "create_listing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Listings.create_listing(@invalid_attrs)
    end

    test "update_listing/2 with valid data updates the listing" do
      listing = listing_fixture()
      update_attrs = %{brand: "some updated brand", condition: "some updated condition", location: "some updated location", name: "some updated name", purchase_date: "some updated purchase_date"}

      assert {:ok, %Listing{} = listing} = Listings.update_listing(listing, update_attrs)
      assert listing.brand == "some updated brand"
      assert listing.condition == "some updated condition"
      assert listing.location == "some updated location"
      assert listing.name == "some updated name"
      assert listing.purchase_date == "some updated purchase_date"
    end

    test "update_listing/2 with invalid data returns error changeset" do
      listing = listing_fixture()
      assert {:error, %Ecto.Changeset{}} = Listings.update_listing(listing, @invalid_attrs)
      assert listing == Listings.get_listing!(listing.id)
    end

    test "delete_listing/1 deletes the listing" do
      listing = listing_fixture()
      assert {:ok, %Listing{}} = Listings.delete_listing(listing)
      assert_raise Ecto.NoResultsError, fn -> Listings.get_listing!(listing.id) end
    end

    test "change_listing/1 returns a listing changeset" do
      listing = listing_fixture()
      assert %Ecto.Changeset{} = Listings.change_listing(listing)
    end
  end
end
