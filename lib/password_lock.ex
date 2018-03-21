defmodule PasswordLock do
  @moduledoc """
  Documentation for PasswordLock
  locks the password
  """

  use GenServer

  # -----------
  # Client API
  # -----------

  @doc """
  Initiate a new server with the given password
  """
  def start_link(password) do
    GenServer.start_link(__MODULE__, password, [])
  end

  @doc """
  Unlocks the given password
  """
  def unlock(pid, password) do
    GenServer.call(pid, {:unlock, password})
  end

  @doc """
  Resets the given password
  """
  def reset(pid, {old_password, new_password}) do
    GenServer.call(pid, {:reset, {old_password, new_password}})
  end

  # -----------
  # Server API
  # -----------

  @doc """
  Init a new server
  """
  def init(password) do
    {:ok, [password]} # --- store password in the state
  end

  @doc """
  Handle the unlock call ----> synchronous request
  """
  def handle_call({:unlock, password}, _from, state) do
    if password in state do
      {:reply, :ok, state}
    else
      write_to_logfile(password)
      {:reply, {:error, "wrong password"}, state}
    end
  end

  @doc """
  Handle the reset call ----> synchronous request
  """
  def handle_call({:reset, {old_password, new_password}}, _from, state) do
    if old_password in state do
      new_state = List.delete(state, old_password)
      {:reply, :ok, [new_password | new_state]}
    else
      write_to_logfile(new_password)
      {:reply, {:error, "wrong password"}, state}
    end
  end

  defp write_to_logfile(msg) do
    {:ok, pid} = PasswordLogger.start_link()
    PasswordLogger.log_incorrect(pid, "wrong password #{msg}")
  end
end
