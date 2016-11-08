class User < ApplicationRecord
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: { in: 3..72 }, on: :create

  has_many :bills, dependent: :destroy

  has_many :contracts
  has_many :payables, -> { distinct }, through: :contracts, :source => :bill

  has_secure_password

  def self.authenticate(params)
    User.find_by_email(params[:email]).try(:authenticate, params[:password])
  end
end

# # User has many bills known as payables through contracts
# #{ distinct } shows only an instance of a bill if there happens to be a duplicate during a query
#
# payee = User.find( *id* )
# payables = payee.payables #=> returns all bills containing contracts referenced to the payee
#
# Using the bill ids found perform:
# Bill.find( *bill_id* ).items_for_user( *user_id* ) #=> returns all items from the bill that has been referened to the payee
