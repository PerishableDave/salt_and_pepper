defmodule SaltAndPepper.Service.APNS.Payload do
  defstruct alert: nil, badge: nil, sound: nil, content_available: nil, category: nil

  def serialize(payload) do
    payload
    |> Map.from_struct
    |> normalize_payload
    |> Poison.encode!
  end

  def normalize_payload(map) do
    map
    |> Enum.filter(fn({_key, value}) -> !is_nil(value) end)
    |> Enum.reduce(%{}, &train_case_keys/2)
  end

  def train_case_keys({key, value}, acc) do
    new_key = key
    |> Atom.to_string
    |> String.replace("_", "-")
    Map.put(acc, new_key, value)
  end
end
