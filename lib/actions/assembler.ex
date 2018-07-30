defmodule DataMapper.Actions.Assembler do
    alias DataMapper.Actions.{Query, Meta, Utils, Data}
    
    def assemble_query(table_name, params) do

        primary_key = Utils.get_primary_key(
            Meta.get_primary_key(table_name)
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
                secondary_indexes = Meta.get_global_indexes(table_name)
                Enum.each(secondary_indexes, fn secondary_map ->
                name  = Map.get(secondary_map, "name")
                attr  = Map.get(name, "AttributeName") 
                index = Map.get(secondary_map, "index")
                if !Query.has_key_condition(pid) do
                    if attr == Atom.to_string(key) do
                    Query.add_key_condition(pid, Atom.to_string(key), value)
                    Query.add_index(pid, index)
                    new_params = Map.delete(params, key)
                    Enum.each(new_params, fn {key, value} ->
                        if Query.has_key_condition(pid) do
                        Query.add_filter(
                            pid,
                            Atom.to_string(key),
                            value
                        )
                        end
                    end)
                    end
                end
                end)
            end)
        end
        Query.get(pid, table_name)
    end

    def scan() do
        
    end
end