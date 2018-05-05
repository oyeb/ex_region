defmodule ExRegion do
  @moduledoc """

  Almost all *nix systems come with the `pkg-isocodes`. Most distros source this
  package from the famous Debian [iso-codes][debian-iso] repo.

  The package makes its `data` available at `/usr/share/iso-codes`, so why don't
  we use it? It even comes with translations for almost all locales too (made
  accessible by `dgettext` in `libintl.h`) .

  > Let's do away with poorly maintained data sources in other packages on
    GitHub or other service APIs.

  [debian-iso]: https://salsa.debian.org/iso-codes-team/iso-codes
  """

  @base_path "/usr/share/iso-codes/json/"

  defmacro __using__(opts) do
    iso_data_filename = Keyword.fetch!(opts, :iso_data)
    iso_data_filepath = Path.join(@base_path, [iso_data_filename, ".", "json"])

    quote do
      def load, do: File.read(unquote(iso_data_filepath))
    end
  end
end
