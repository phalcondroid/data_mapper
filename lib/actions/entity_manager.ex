defmodule DataMapper.Actions.EntityManager do
    alias DataMapper.Actions.{Assembler, Data, Query}

    def find(table, params \\ %{}) do
        {:ok, pid} = Data.start_link
        Assembler.assemble_query(pid, table, params)
        Query.get(pid, table)
    end

    def find_one(table, params \\ %{}) do
        {:ok, pid} = Data.start_link
        Assembler.assemble_query(pid, table, params)
        Query.add_limit(pid, 1)
        Query.get(pid, table)
    end

    def count(table, params \\ %{}) do
        {:ok, pid} = Data.start_link
        Assembler.assemble_query(pid, table, params)
        Query.add_count(pid)
        Query.get(pid, table)
    end

    def save(struct) do
        
    end
end