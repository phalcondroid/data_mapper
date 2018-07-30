defmodule DataMapper do
  alias ExAws.Dynamo
  alias DataMapper.Actions.{Assembler}

  '''
  def start(_type, _args) do
    IO.puts "datamapper starting"

    params = %{
      username: "alexbilbie",
      profile: "Developer",
      twoFactorEnabled: true,
      name: "Alex Bilbie"
    }

    IO.inspect Query.get_struct(pid)

    IO.inspect Query.get(pid, "bz_administrators")

    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
  '''
end

