defmodule Elixirsandbox do
  @moduledoc """
  Documentation for Elixirsandbox.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elixirsandbox.hello
      :world

  """

  def main([]) do
    IO.puts "Provide name of the repository"
  end

  def main([org_name|_]) do
    IO.puts "#{org_name} repositories"
    IO.puts "----------------------"
    token = case File.read(Path.expand("~/.github_token")) do
      {:ok, body} -> body
      {:error, error} -> IO.puts(error); exit(1) 
    end
    client = Tentacat.Client.new(%{access_token: String.strip(token)})
    IO.puts "Client is #{inspect(client)}"
    
    names = Tentacat.Repositories.list_orgs(org_name, client, [type: "private"])
            |> Enum.map(&(&1["name"]))
    Enum.each(names, fn(name) ->
      map = Tentacat.Repositories.Languages.list(org_name, name, client)
      Enum.each(map, fn({k, v}) -> IO.puts "#{name}, #{k}, #{v}" end)
    end)
    #Enum.flat_map(names, fn name do
    #  languages =       
      #end
    IO.puts Enum.join(names, "\n")
    #repos |> Enum.map(Tentacat.Repositories.Languages.list )

    #IO.puts "Jobseeker: #{jobseeker}"
  end
end
