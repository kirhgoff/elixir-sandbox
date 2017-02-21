defmodule Organisation do
  @derive [Poison.Encoder]
end

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
  def hello do
    :world
  end

  def main(args) do
    IO.puts "Jobseeker repositories"
    IO.puts "----------------------"
    token = case File.read(Path.expand("~/.github_token")) do
      {:ok, body} -> body
      {:error, error} -> IO.puts(error); exit(1) 
    end
    client = Tentacat.Client.new(%{access_token: String.strip(token)})
    IO.puts "Client is #{inspect(client)}"
    repos = Tentacat.Repositories.list_orgs("jobseekerltd", client, [type: "private"])
    names = Enum.map(repos, fn v -> v["name"] end)
    IO.puts Enum.join(names, "\n")
    #repos |> Enum.map(Tentacat.Repositories.Languages.list )

    #IO.puts "Jobseeker: #{jobseeker}"
  end
end
