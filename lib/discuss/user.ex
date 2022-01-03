defmodule Discuss.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :last_name, :string
    field :first_name, :string
    field :nickname, :string
    field :phone, :string
    field :birthday, :string
    field :description, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
   struct
   |> cast(params, [:email, :provider, :token, :last_name, :first_name, :nickname, :phone, :birthday, :description])
   |> validate_required([:email, :provider, :token])
  end
end
