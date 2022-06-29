defmodule BiddingApi.Repo do
  use Ecto.Repo,
    otp_app: :bidding_api,
    adapter: Ecto.Adapters.Postgres
end
