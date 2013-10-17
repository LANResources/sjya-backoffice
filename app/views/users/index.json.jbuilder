json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :email, :password_digest, :title, :phone, :address, :city, :state, :zipcode, :avatar
  json.url user_url(user, format: :json)
end
