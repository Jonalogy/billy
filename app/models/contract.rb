class Contract < ApplicationRecord
  belongs_to :item
  has_one :payment_type
  has_one :user
end
