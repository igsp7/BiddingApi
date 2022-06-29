defmodule BiddingApiWeb.Router do
  use BiddingApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BiddingApiWeb do
    pipe_through :api

    get "/auctions/:id/start", AuctionController, :start
    get "/auctions/:id/stop", AuctionController, :stop
    get "/auctions/details", AuctionDetailsController, :index
    get "/auctions/:id/details", AuctionDetailsController, :show

    resources "/listings", ListingController, except: [:new, :edit]
    resources "/auctions", AuctionController, except: [:new, :edit]
    resources "/bids", BidController, except: [:new, :edit]


  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
