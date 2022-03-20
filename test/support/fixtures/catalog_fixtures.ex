defmodule Ecrate.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecrate.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Ecrate.Catalog.create_product()

    product
  end
end
