json.extract! boat, :id, :title, :description, :boat_dimensions, :place, :rating, :created_at, :updated_at
json.url boat_url(boat, format: :json)
