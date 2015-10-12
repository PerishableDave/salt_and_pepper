defmodule SaltAndPepper.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(SaltAndPepper.Service.APNS.Supervisor, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
