# Fast EIP-55

Encode and validate Ethereum addresses fast!

FastEIP55 is a derivative work of unnawut's [EIP-55](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md).

The original version uses a pure elixir version. This version makes 2 substantial changes.

* replaces pure slow elixir keccak version with the much faster rust-powered one [Ex_Keccak](https://github.com/tzumby/ex_keccak)
* replaces easy-to-read logic, with harder-to-read optimized logic

I've kept the library interface the same, and have kept the original tests. I'm taking some liberty with the `to_upper` logic and might tweak things a bit if I uncover issues. I've also have some additional performance tweaks that I'd like to experiment with. Many thanks to unnawut for the original implemenation and tests!

## Installation

The package can be installed by adding `:fast_eip_55` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [
    {:fast_eip_55, "~> 0.1"}
  ]
end
```

## Usage

Encoding:

```elixir
iex> alias FastEIP55, as: EIP55
iex> EIP55.encode("0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed")
{:ok, "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"}

iex> EIP55.encode(<<90, 174, 182, 5, 63, 62, 148, 201, 185, 160,
...> 159, 51, 102, 148, 53, 231, 239, 27, 234, 237>>)
{:ok, "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"}
```

Validation:

```elixir
iex> alias FastEIP55, as: EIP55
iex> EIP55.valid?("0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed")
true

iex> EIP55.valid?("0x5AAEB6053f3e94c9b9a09f33669435e7ef1beaed")
false
```

Full documentation can be found at [https://hexdocs.pm/fast_eip_55](https://hexdocs.pm/fast_eip_55).

## Performance


## License

FastEIP-55 is released under the MIT License. See [LICENSE](./LICENSE) for further details.
