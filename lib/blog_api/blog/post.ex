defmodule BlogApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogApi.Accounts.User

  @type t :: %__MODULE__{
          id: integer,
          title: String.t(),
          body: String.t(),
          published_at: NaiveDateTime.t(),
          views: integer,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t(),
          user: User.t()
        }
  schema "posts" do
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime
    field :views, :integer

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
