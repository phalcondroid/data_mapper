defmodule DataMapper.Actions.Data do
    use Agent, restart: :transient

    def start_link() do
        random = Integer.to_string(DateTime.utc_now() |> DateTime.to_unix())
        Agent.start_link(fn -> %{} end, name: "datamapper_start_link" <> random)
    end

    def add(pid, key, value) do
        Agent.update(pid, fn map ->
            Map.put(map, key, value)
        end)
    end

    def update(pid, key, new_value) do
        Agent.update(pid, fn map ->
            Map.replace!(map, key, new_value)
        end)
    end

    def get_all(pid) do
        Agent.get(pid, fn map ->
            map
        end)
    end

    def has_key(pid, key) do
        Agent.get(pid, fn map ->
            Map.has_key?(map, key)
        end)
    end

    def get(pid, key) do
        Agent.get(pid, fn map ->
            Map.get(map, key)
        end)
    end

    def reset(pid) do
        Agent.update(pid, fn map -> %{} end)
    end
end