defmodule DataMapper.Actions.Utils do
    def get_primary_key(list) do
        primary_map = List.first(list)
        String.to_atom(Map.get(primary_map, "AttributeName"))
    end
end