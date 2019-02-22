json.extract! account, :id, :username, :email, :name, :created_at, :updated_at
json.url account_url(account, format: :json)
