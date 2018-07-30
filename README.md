# DataMapper

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `data_mapper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:data_mapper, "~> 0.1.0"}
  ]
end
```

### Find
```elixir

EntityManager.find("bz_administrators", %{
  username: "alexbilbie",
  profile: "Developer",
  twoFactorEnabled: true,
  name: "Alex Bilbie"
})

```

### Find one
```elixir

EntityManager.find_one("bz_administrators", %{
  username: "alexbilbie",
  profile: "Developer",
  twoFactorEnabled: true,
  name: "Alex Bilbie"
})

```

### count
```elixir

EntityManager.count("bz_administrators", %{
  username: "alexbilbie",
  profile: "Developer",
  twoFactorEnabled: true,
  name: "Alex Bilbie"
})

```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/data_mapper](https://hexdocs.pm/data_mapper).

