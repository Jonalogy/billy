json.extract! item, :id, :bill_id, :item_name, :item_price, :contract_id, :created_at, :updated_at
json.url item_url(item, format: :json)