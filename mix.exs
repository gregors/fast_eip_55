defmodule FastEIP55.MixProject do
  use Mix.Project

  @repo_url "https://github.com/gregors/fast_eip_55"

  def project do
    [
      app: :fast_eip_55,
      version: "0.1.1",
      description: "Faster Rust Keccak implementation of EIP-55. Encode and validate an Ethereum address against EIP-55 checksum in Elixir. ",
      name: "Fast EIP-55",
      package: package(),
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      source_url: @repo_url,
      deps: deps()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Gregory Ostermayr"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  defp deps do
    [
      {:ex_keccak, "~> 0.3.0"},
      {:ex_doc, ">= 0.19.0", only: :dev}
    ]
  end
end
