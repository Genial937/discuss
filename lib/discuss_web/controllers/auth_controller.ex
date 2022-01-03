defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  alias Discuss.User
  alias Discuss.Repo
  import Ecto.Query, warn: false

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
  user_params = %{
    token: auth.credentials.token,
     email: auth.info.email,
     last_name: auth.info.last_name,
     first_name: auth.info.first_name,
     nickname: auth.info.nickname,
     phone: auth.info.phone,
     birthday: auth.info.birthday,
     description: auth.info.description,
     provider: "github"
    }
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
     case insert_or_update_user(changeset) do
         {:ok, user} ->
          conn
          |> put_flash(:info, "Sign in successful, welcome back!")
          |> put_session(:user_id, user.id)
          |> redirect(to: Routes.topic_path(conn, :index))
         {:error, _reason} ->
          conn
          |> put_flash(:error, "Error signing in")
          |> redirect(to: Routes.topic_path(conn, :index))
     end
  end

  defp insert_or_update_user(changeset) do
   case Repo.get_by(User, email: changeset.changes.email) do
    nil -> Repo.insert(changeset)
    user ->
      {:ok, user}
   end
  end
end
