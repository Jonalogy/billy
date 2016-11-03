class PayeeController < ApplicationController

  def verify_mobile
    number = params[:number][:payee_contact]

    if User.where(mobile_number: number).exists? == true
       data = {}
       data[:check] = true
       data[:owner] = User.where(mobile_number: number).take.name
       data[:owner_id] = User.where(mobile_number: number).take.id

       render json: data
    end

    if User.where(mobile_number: number).exists? == false
      data = {}
      data[:check] = false

      render json: data
    end


  end

  private

  def payee_number
    params.require(:number).permit(:payee_contact)
  end

end
