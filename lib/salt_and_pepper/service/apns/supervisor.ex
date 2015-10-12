defmodule SaltAndPepper.Service.APNS.Supervisor do
  use Supervisor

  alias SaltAndPepper.Service.APNS.Pool

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(opts) do
    children = [
      # worker(Pool, opts)
    ]
    supervise(children, strategy: :one_for_one)
  end
end
