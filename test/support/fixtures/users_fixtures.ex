defmodule BiddingApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BiddingApi.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> BiddingApi.Users.create_user()

    user
  end
end
