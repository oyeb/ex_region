defmodule Mix.Tasks.ExRegion.Sync do
  use Mix.Task

  @project_name URI.encode_www_form("iso-codes-team/iso-codes")
  @base_url "https://salsa.debian.org/api/v4/projects/#{@project_name}/"
  @tags "/repository/tags"

  def run(_args) do
    data_path = Path.join(Mix.Project.build_path(), "iso_data")

    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)
    url = String.to_charlist(@base_url <> @tags)

    {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} = :httpc.request(:get, {url, []}, [], [])

    %{
      "name" => name,
      "commit" => %{"id" => commit_id}
    } =
      body
      |> to_string()
      |> Poison.decode!()
      |> List.first()

    IO.inspect([name, commit_id])
    IO.inspect(data_path)

    version_file_path = Path.join(data_path, "version.txt")

    if File.exists(data_path) do
      if File.exists?(version_file_path) do
        File.read(version_file_path)
        |> IO.inspect()
      end
    else
      Mix.Generator.create_directory(data_path)
      Mix.Generator.create_file(version_file_path, name <> "\n" <> commit_id, force: true)
    end
  end
end
