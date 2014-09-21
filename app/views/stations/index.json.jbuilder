json.array!(@stations) do |station|
  json.extract! station, :id, :legal_name, :counter_honesty, :counter_speed_service, :counter_customer_service, :counter_comments
  json.url station_url(station, format: :json)
end
