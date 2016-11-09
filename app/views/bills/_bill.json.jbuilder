json.extract! bill, :id, :user_id, :title, :description, :total_price, :since, :clear, :created_at, :updated_at
json.url bill_url(bill, format: :json)