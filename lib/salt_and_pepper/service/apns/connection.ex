defmodule SaltAndPepper.Service.APNS.Connection do
  use GenServer

  @apns_server "gateway.sandbox.push.apple.com"
  @apns_port 2195

  def start_link do
    GenServer.start_link(__MODULE__, %{socket: nil})
  end

  def send(payload) do
    GenServer.cast({:send, payload})
  end

  # Callbacks

  def init(state) do
    opts = [:binary, active: false]
    {:ok, socket} = :gen_tcp.connect(@apns_server, @apns_port, opts)
    {:ok, %{state | socket: socket}}
  end

  def handle_cast({:send, message}, %{socket: socket} = state) do
    :ok = :gen_tcp.send(socket, message)
    {:noreply, state}
  end

  def handle_info({:tcp, socket, msg}, %{socket: socket} = state) do

  end
end
