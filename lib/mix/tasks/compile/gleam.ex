defmodule Mix.Tasks.Compile.Gleam do
  use Mix.Task.Compiler

  def run(_args) do
    System.cmd("gleam", ["build"])
    |> get_and_reload_files()

    :ok
  end

  defp get_and_reload_files(gleam_build_output) do
    if Mix.env() == :dev && should_reload_files?() do
      gleam_build_output
      |> get_list_of_compiled_files()
      |> convert_files_to_modules()
      |> reload_modules()
    end
  end

  defp get_list_of_compiled_files({string, 0}) do
    string
    |> String.split("\n")
    |> Enum.filter(&String.starts_with?(&1, "Compiling"))
    |> Enum.map(&String.replace(&1, "Compiling ", ""))
    |> Enum.map(&String.trim/1)
  end

  defp get_list_of_compiled_files(_), do: []

  defp convert_files_to_modules(files) do
    files
    |> Enum.map(&String.replace(&1, "/", "@"))
    |> Enum.map(&String.to_atom/1)
    |> Enum.map(&Code.ensure_loaded/1)
  end

  defp reload_modules(modules) do
    Enum.map(modules, fn
      {:error, :nofile} ->
        Mix.Task.reenable("compile.erlang")
        Mix.Task.run("compile.erlang")

      {:module, module} ->
        IEx.Helpers.r(module)

      _ ->
        :noop
    end)
  end

  defp should_reload_files?(), do: Application.get_env(:gleam_compile, :reload, true)
end
