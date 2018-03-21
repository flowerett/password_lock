defmodule PasswordLogger do
  @moduledoc """
  Documentation for PasswordLogger
  logs password errors
  """

  use GenServer

  # -----------
  # Client API
  # -----------

  @doc """
  Initiate with given filename
  """
  def start_link do
    GenServer.start_link(__MODULE__, "tmp/password_logs", [])
  end

  @doc """
  cast log message
  """
  def log_incorrect(pid, msg) do
    GenServer.cast(pid, {:log, msg})
  end

  # -----------
  # Server API
  # -----------

  def init(logfile) do
    {:ok, logfile}
  end

  def handle_cast({:log, msg}, filename) do
    ensure_file(filename)

    {:ok, file} = File.open(filename, [:append])
    IO.binwrite(file, msg <> "\n")
    File.close(file)

    {:noreply, filename}
  end

  defp ensure_file(filename) do
    File.exists?(filename) || File.touch(filename)
    File.chmod!(filename, 0o755)
  end
end
