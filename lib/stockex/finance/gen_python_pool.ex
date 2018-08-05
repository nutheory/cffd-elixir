defmodule Stockex.Finance.GenPythonPool do
  use Piton.Port
  @timeout 5000

  def start() do
    IO.inspect("START")
    Stockex.Finance.GenPythonPool.start([path: Path.expand("lib/pylib"), python: "python"], [])
  end

  def reg(pid, n, timeout \\ @timeout) do
    Stockex.Finance.GenPythonPool.execute(pid, :regression, :regression, [n])
  end
end
