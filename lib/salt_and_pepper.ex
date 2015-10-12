defmodule SaltAndPepper do
  use Application

  def start(_type, _args) do
    SaltAndPepper.Supervisor.start_link
  end
end
