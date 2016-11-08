class Contract < ApplicationRecord
  belongs_to :user #payee

  belongs_to :item

  has_one :bill, through: :item

  has_one :payment_type

  has_one :favour
end
