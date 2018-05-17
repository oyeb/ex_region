defmodule ExRegion.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_region,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.9.1", only: [:dev, :test]}
    ]
  end
end
