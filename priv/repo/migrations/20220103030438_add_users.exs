defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string
      add :last_name, :string
      add :first_name, :string
      add :nickname, :string
      add :phone, :string
      add :birthday, :string
      add :description, :string

      timestamps()
    end
  end
end
