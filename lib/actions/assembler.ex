defmodule DataMapper.Actions.Assembler do

    alias DataMapper.Actions.Meta
    
    def query(table_name, params) do
        primary_key = Meta.get_primary_key(table_name)
        secondary_index = Meta.get_global_indexes(table_name)

        Enum.each(
            params,
            fn item ->
            end
        )
    end

    def scan() do
        
    end
end