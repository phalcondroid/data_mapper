defmodule DataMapper do
  alias ExAws.Dynamo
  alias DataMapper.Actions.{Query, EntityManager, Meta, Utils, Data}

  def start(_type, _args) do
    IO.puts "datamapper starting"

    params = %{
      _id: "kjkasjkajsk",
      profile: "Developer"
    }

    primary_key = Utils.get_primary_key(
      Meta.get_primary_key("bz_administrators")
    )

    {:ok, pid} = Data.start_link
    exist_pk = Map.get(params, primary_key)
    if exist_pk != nil do
      Query.add_key_condition(pid, Atom.to_string(primary_key), exist_pk)
      new_params = Map.delete(params, primary_key)
      Enum.each(new_params, fn {key, value} ->
        Query.add_filter(
          pid,
          Atom.to_string(key),
          value
        )
      end)
    else
      Enum.each(params, fn {key, value} ->
        if Query.has_key_condition(pid) do
          Query.add_filter(
            pid,
            Atom.to_string(key),
            value
          )
        else
          already_added = []
          secondary_indexes = Meta.get_global_indexes("bz_administrators")
          Enum.each(secondary_indexes, fn secondary_map ->
            if Query.has_key_condition(pid) == nil do
              name  = Map.get(secondary_map, "name")
              attr  = Map.get(name, "AttributeName") 
              index = Map.get(secondary_map, "index")
              if Map.has_key?(secondary_map, )
              Query.add_key_condition(pid, Atom.to_string(key), value)
              already_added ++ [key]
            end
          end)
          if Enum.member?(already_added, key) == false do
            Query.add_filter(
              pid,
              Atom.to_string(key),
              value
            )
          end
        end
      end)
    end

    IO.inspect Query.get_struct(pid)

    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end

  def query() do
    Query
  end

  def data_mapper() do
    EntityManager
  end
end

