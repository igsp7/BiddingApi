defmodule BiddingApiWeb.AuctionControllerTest do
  use BiddingApiWeb.ConnCase

  import BiddingApi.AuctionsFixtures

  alias BiddingApi.Auctions.Auction

  @create_attrs %{
    buy_now_price: 120.5,
    description: "some description",
    email: "some email",
    end_date: ~U[2022-06-27 13:12:00Z],
    start_date: ~U[2022-06-27 13:12:00Z],
    starting_price: 120.5,
    status: "some status",
    title: "some title"
  }
  @update_attrs %{
    buy_now_price: 456.7,
    description: "some updated description",
    email: "some updated email",
    end_date: ~U[2022-06-28 13:12:00Z],
    start_date: ~U[2022-06-28 13:12:00Z],
    starting_price: 456.7,
    status: "some updated status",
    title: "some updated title"
  }
  @invalid_attrs %{buy_now_price: nil, description: nil, email: nil, end_date: nil, start_date: nil, starting_price: nil, status: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all auctions", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create auction" do
    test "renders auction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.auction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "buy_now_price" => 120.5,
               "description" => "some description",
               "email" => "some email",
               "end_date" => "2022-06-27T13:12:00Z",
               "start_date" => "2022-06-27T13:12:00Z",
               "starting_price" => 120.5,
               "status" => "some status",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update auction" do
    setup [:create_auction]

    test "renders auction when data is valid", %{conn: conn, auction: %Auction{id: id} = auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.auction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "buy_now_price" => 456.7,
               "description" => "some updated description",
               "email" => "some updated email",
               "end_date" => "2022-06-28T13:12:00Z",
               "start_date" => "2022-06-28T13:12:00Z",
               "starting_price" => 456.7,
               "status" => "some updated status",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, auction: auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete auction" do
    setup [:create_auction]

    test "deletes chosen auction", %{conn: conn, auction: auction} do
      conn = delete(conn, Routes.auction_path(conn, :delete, auction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.auction_path(conn, :show, auction))
      end
    end
  end

  defp create_auction(_) do
    auction = auction_fixture()
    %{auction: auction}
  end
end
