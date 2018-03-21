defmodule PasswordLockTest do
  use ExUnit.Case
  doctest PasswordLock

  setup do
    {:ok, pid} = PasswordLock.start_link("secret")
    {:ok, server: pid}
  end

  test "unlock succeeds", %{server: pid} do
    assert :ok == PasswordLock.unlock(pid, "secret")
  end

  test "unlock fails", %{server: pid} do
    assert {:error, "wrong password"} == PasswordLock.unlock(pid, "fake")
  end

  test "reset succeeds", %{server: pid} do
    assert :ok == PasswordLock.reset(pid, {"secret", "newpassword"})
  end

  test "reset fails", %{server: pid} do
    assert {:error, "wrong password"} == PasswordLock.reset(pid, {"fake", "newpassword"})
  end
end
