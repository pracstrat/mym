json.array!(@categories) do |category|
  json.extract! category, :id
  json.extract! category, :name
end
