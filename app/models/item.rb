class Item < ApplicationRecord
  belongs_to :bill
  has_many :contracts, dependent: :destroy
end
