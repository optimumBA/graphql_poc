# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogApi.Repo.insert!(%BlogApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for i <- 1..50 do
  :timer.sleep(100)
  BlogApi.Repo.insert!(%BlogApi.Blog.Post{
    title: "My First Post #{i}",
    body: "This is my first post #{i}",
    published_at: NaiveDateTime.truncate(NaiveDateTime.add(NaiveDateTime.utc_now(), -i * 1000), :second)
  })
end
