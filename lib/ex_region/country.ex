defmodule ExRegion.Country do
  @moduledoc """
  Countries from ISO 3166-1.

  ## Schema

  The ISO 3166-1 country schema, for complete reference please refer the
  Wikipedia article on [ISO 3166-1][wiki].

  [wiki]: https://en.wikipedia.org/wiki/ISO_3166-1
  """

  use ExRegion, iso_data: "iso_3166-1"

  # @schema ~w[alpha_2 alpha_3 name numeric official_name common_name]a
  @iso :"3166-1"

  def fetch_all do
    with {:ok, data} <- load(),
         {:ok, countries} <- Jason.decode(data, keys: :atoms) do
      Map.fetch!(countries, @iso)
    end
  end

  def fetch_all!, do: Enum.into([], fetch_all())
end
