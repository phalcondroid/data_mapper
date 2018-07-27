defmodule DataMapper.Actions.Query do
    alias DataMapper.Actions.{Data}
    @attr_expr "_expression"
    @table_prefix "wwd_dev_"

    def add_key_condition(pid, field, value, pk \\ false) do
        with_expr = field <> @attr_expr
        Data.add(pid, :key_condition_expression, "#" <> field <> " = :" <> with_expr)
        Data.add(pid, :expression_attribute_values, ["#{with_expr}": value])
        Data.add(pid, :expression_attribute_names, %{"#" <> field => field})
    end

    def has_key_condition(pid) do
        Data.has_key(pid, :key_condition_expression)
    end
    
    def add_filter(pid, field, value, comparison \\ "=", operator \\ "and") do
        with_expr = field <> @attr_expr
        
        if !Data.has_key(pid, :filter_expression) do
            Data.add(pid, :filter_expression, "#" <> field <> " #{comparison} :" <> field <> @attr_expr)
        else
            old_filter = Data.get(pid, :filter_expression)
            new_filter = old_filter <> " operator " <> "#" <> field <> " = :" <> field <> @attr_expr
            Data.update(pid, :filter_expression, new_filter)
        end
    
        if Data.has_key(pid, :expression_attribute_values) == false do
            Data.add(pid, :expression_attribute_values, ["#{with_expr}": value])
        else
            old_list = Data.get(pid, :expression_attribute_values)
            new_list = old_list ++ ["#{with_expr}": value]
            Data.update(pid, :expression_attribute_values, new_list)
        end
    
        if Data.has_key(pid, :expression_attribute_names) == false do
            Data.add(pid, :expression_attribute_names, %{"#" <> field => field})
        else
            old_map = Data.get(pid, :expression_attribute_names)
            new_map = Map.merge(old_map, %{"#" <> field => field})
            Data.update(pid, :expression_attribute_names, new_map)
        end
    end
    
    def count(pid) do
        Data.add(pid, :select, :count)
    end
    
    def sort(pid, sort) do
        accending =
          case sort do
            true -> 1
            1 -> 1
            _ -> 0
          end
        Data.add(pid, :scan_index_forward, accending)
    end
    
    def get_struct(pid) do
        Map.to_list(Data.get_all(pid))
    end
    
    def add_limit(pid, limit) do
        Data.add(pid, :limit, limit)
    end
    
    def get(pid, table_name) do
        struct = get_struct(pid)
        if Data.get(pid, :select) == :count do
            data = Dynamo.query(
                @table_prefix <> table_name,
                struct
            ) |> ExAws.request!
            if is_map(data) do
                Map.get(data, "Count")
            else
                false
            end
        else
            data = Dynamo.query(
                @table_prefix <> table_name,
                struct
            ) |> ExAws.request!
            if is_map(data) do
                Map.get(data, "Items")
            else
                false
            end
        end
    end
end