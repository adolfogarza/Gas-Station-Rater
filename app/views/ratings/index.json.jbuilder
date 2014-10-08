json.array!(@ratings) do |rating|
  json.extract! rating, :id, :honesty, :speed_service, :customer_service
  json.url rating_url(rating, format: :json)
end
