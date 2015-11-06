defmodule SaltAndPepper.Service.APNS.Pool do
  @moduledoc """
  Starts a pool of APNS connections.

  ### Options

    * `:pool_size` - The number of connections to keep in the pool (default: 5)
    * `:pool_max_overflow` - The maximum overflow for the pool (defualt: 0)
  """

  @default_ops [
    size: 5,
    max_overflow: 0
  ]
  def start_link(opts) do
    poolboy_opts = build_opts(opts)
    {:ok, _} = Application.ensure_all_started(:poolboy)
    :poolboy.start_link(poolboy_opts, [])
  end

  def transaction(func) do
    :poolboy.transaction(__MODULE__, func)
  end

  defp build_opts(opts) do
    [name: __MODULE__,
     size: Dict.get(opts, :pool_size, 5),
     max_overflow: Dict.get(opts, :pool_max_overflow, 0)]
  end

end
