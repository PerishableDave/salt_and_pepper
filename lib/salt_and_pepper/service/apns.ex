defmodule SaltAndPepper.Service.APNS do
  alias SaltAndPepper.Service.APNS.Pool
  alias SaltAndPepper.Service.APNS.Connection

  def send(notification) do
    Pool.transaction(fn(conn) ->
      Connection.send_message(conn, notification)
    end)
  end
end
