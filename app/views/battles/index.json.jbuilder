json.array!(@battles) do |battle|
  json.extract! battle, :id, :contestant, :phase, :location
  json.url battle_url(battle, format: :json)
end
