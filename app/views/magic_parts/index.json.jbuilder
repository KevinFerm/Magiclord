json.array!(@magic_parts) do |magic_part|
  json.extract! magic_part, :id, :title, :type, :effect
  json.url magic_part_url(magic_part, format: :json)
end
