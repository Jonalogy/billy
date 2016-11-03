class PayeeController < ApplicationController

  def verify_mobile
    number = params[:number][:payee_contact]
    @user = User.where(mobile_number: number ).exists?

    render json: @user
  end

  private

  def payee_number
    params.require(:number).permit(:payee_contact)
  end

end
