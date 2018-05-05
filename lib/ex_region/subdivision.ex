defmodule ExRegion.Subdivision do
  @moduledoc """
  Subdivisions of countries listed in ISO 3166-1, from ISO 3166-2.

  ## Schema

  The ISO 3166-2 country schema, but slightly better.

  Please refer the Wikipedia article on [ISO 3166-2][wiki] for a complete
  reference on what each field in their schema means.

  The `:code` is split into two parts: `<<country::2, "-", sub_code>>
  * The `:country` field is the `:alpha_2` code of the country this subdivision
    belongs to.

  > The `sub_code` is not available in the struct as it has _no meaning_ or
  > _identity on its own_. A subdivision can be identified only by it's full
  > `:code`, as per ISO standards.

  [wiki]: https://en.wikipedia.org/wiki/ISO_3166-2
  """

  use ExRegion, iso_data: "iso_3166-2"

  # @schema ~w[name code type parent country]a
  @iso :"3166-2"

  def fetch_all do
    with {:ok, data} <- load(),
         {:ok, countries} <- Jason.decode(data, keys: :atoms) do
      countries
      |> Map.fetch!(@iso)
      |> Stream.map(fn %{code: code} = s ->
        Map.put(s, :country, String.slice(code, 0..1))
      end)
    end
  end

  def fetch_all!, do: Enum.into([], fetch_all())

  def group_by_country(stream) do
    stream
    |> Enum.reduce(%{}, fn %{country: country} = x, acc ->
      Map.update(acc, country, [x], fn xs ->
        [x | xs]
      end)
    end)
  end
end
