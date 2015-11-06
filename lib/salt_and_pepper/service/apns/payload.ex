defmodule SaltAndPepper.Service.APNS.Payload do
  defstruct alert: nil, badge: nil, sound: nil, content_available: nil, category: nil, user: %{}

  def serialize(payload) do
    {%{user: user}, aps} = Map.split(payload, [:user])

    aps = aps
    |> Map.from_struct
    |> normalize_payload

    user
    |> Map.merge(%{"aps" => aps})
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

  def build_frame(items) do
    frame_length = Enum.reduce(items, 0, &(byte_size(&1) + &2))
    frame = Enum.reduce(items, 0, &(&2 <> &1))
    data = <<2 :: size(8),
             frame_length :: size(64),
             frame>>
  end
end
