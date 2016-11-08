class Item < ApplicationRecord
  belongs_to :bill
  has_many :contracts, dependent: :destroy

  has_many :payees, through: :contracts, :source => :user
end
