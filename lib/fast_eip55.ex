defmodule FastEIP55 do
  @moduledoc """
  Github link: https://github.com/gregors/fast_eip_55
  Rust-powered Keccak version of EIP-55

  Provides EIP-55 encoding and validation functions.
  """

  @doc """
  Encodes an Ethereum address into an EIP-55 checksummed address.

  ## Examples

  iex> alias FastEIP55, as: EIP55
  iex> EIP55.encode("0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed")
  {:ok, "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"}

  iex> EIP55.encode(<<90, 174, 182, 5, 63, 62, 148, 201, 185, 160, 159, 51, 102, 148, 53, 231, 239, 27, 234, 237>>)
  {:ok, "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"}

  iex> EIP55.encode("not an address")
  {:error, :unrecognized_address_format}

  """
  def encode("0x" <> address) when byte_size(address) == 40 do
    address = String.downcase(address, :ascii)

    hash =
      address
      |> ExKeccak.hash_256()
      |> Base.encode16(case: :lower)

    encoded = _encode(address, hash)
    {:ok, encoded}
  end

  def encode(address) when byte_size(address) == 20 do
    encode("0x" <> Base.encode16(address, case: :lower))
  end

  def encode(_) do
    {:error, :unrecognized_address_format}
  end

  defp checksum(c, _) when c >= 48 and c <= 57, do: c

  defp checksum(c, x) when (x >= 97 and x <= 102) or x == 56 or x == 57 do
    c - 32
  end

  defp checksum(c, _), do: c

  defp _encode(address, hash) do
    address = :binary.bin_to_list(address)
    hash = :binary.bin_to_list(hash)

    _encode(address, hash, ['x', '0'])
    |> :lists.reverse()
    |> :binary.list_to_bin()
  end

  defp _encode([], _, acc), do: acc

  defp _encode([a | address], [b | hash], acc) do
    _encode(address, hash, [checksum(a, b) | acc])
  end

  @doc """
  Determines whether the given Ethereum address has a valid EIP-55 checksum.

  ## Examples

  iex> alias FastEIP55, as: EIP55
  iex> EIP55.valid?("0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed")
  true

  iex> EIP55.valid?("0x5AAEB6053f3e94c9b9a09f33669435e7ef1beaed")
  false

  iex> EIP55.valid?("not an address")
  false
  """
  def valid?("0x" <> _ = address) when byte_size(address) == 42 do
    case encode(address) do
      {:ok, ^address} -> true
      _ -> false
    end
  end

  def valid?(_), do: false
end
