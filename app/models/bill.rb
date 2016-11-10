class Bill < ApplicationRecord
  # mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :items, dependent: :destroy


  def items_for_payee(user_id)
    items.includes(:contracts).where( :contracts => { :user_id => user_id} )
  end
end
