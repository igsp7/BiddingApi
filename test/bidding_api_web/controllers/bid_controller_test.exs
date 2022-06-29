defmodule BiddingApiWeb.BidControllerTest do
  use BiddingApiWeb.ConnCase

  import BiddingApi.BidsFixtures

  alias BiddingApi.Bids.Bid

  @create_attrs %{
    ammount: 120.5,
    bid_date: ~U[2022-06-27 14:17:00Z],
    email: "some email"
  }
  @update_attrs %{
    ammount: 456.7,
    bid_date: ~U[2022-06-28 14:17:00Z],
    email: "some updated email"
  }
  @invalid_attrs %{ammount: nil, bid_date: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bids", %{conn: conn} do
      conn = get(conn, Routes.bid_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bid" do
    test "renders bid when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bid_path(conn, :create), bid: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.bid_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ammount" => 120.5,
               "bid_date" => "2022-06-27T14:17:00Z",
               "email" => "some email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bid_path(conn, :create), bid: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bid" do
    setup [:create_bid]

    test "renders bid when data is valid", %{conn: conn, bid: %Bid{id: id} = bid} do
      conn = put(conn, Routes.bid_path(conn, :update, bid), bid: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.bid_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ammount" => 456.7,
               "bid_date" => "2022-06-28T14:17:00Z",
               "email" => "some updated email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bid: bid} do
      conn = put(conn, Routes.bid_path(conn, :update, bid), bid: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bid" do
    setup [:create_bid]

    test "deletes chosen bid", %{conn: conn, bid: bid} do
      conn = delete(conn, Routes.bid_path(conn, :delete, bid))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.bid_path(conn, :show, bid))
      end
    end
  end

  defp create_bid(_) do
    bid = bid_fixture()
    %{bid: bid}
  end
end
