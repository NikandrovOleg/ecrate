# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ecrate.Repo.insert!(%Ecrate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for title <- ["New product", "Another product"] do
  {:ok, _} = Ecrate.Catalog.create_product(%{title: title})
end
