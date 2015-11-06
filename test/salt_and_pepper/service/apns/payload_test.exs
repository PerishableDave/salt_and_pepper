defmodule SaltAndPepper.Service.APNS.PayloadTest do
  use ExUnit.Case

  alias SaltAndPepper.Service.APNS.Payload

  test "serializes to JSON" do
    payload =  %Payload{
      alert: "A Notification",
      badge: 0,
      sound: "pop.aiff",
      content_available: 0,
      category: "TEST"
    }
    serialized_payload = Payload.serialize(payload)

    map = %{
      "aps" => %{
        "alert" => "A Notification",
        "badge" => 0,
        "sound" => "pop.aiff",
        "content-available" => 0,
        "category" => "TEST"
      }
    }
    {:ok, json_map} = Poison.encode(map)

    assert serialized_payload == json_map
  end
end
