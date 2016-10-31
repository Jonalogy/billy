json.extract! user, :id, :name, :mobile_number, :email, :password, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)