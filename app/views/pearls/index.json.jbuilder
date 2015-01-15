json.array!(@pearls) do |pearl|
  json.extract! pearl, :id, :title, :parts, :type, :ep, :effect, :item_id
  json.url pearl_url(pearl, format: :json)
end
