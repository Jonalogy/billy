class PayeeController < ApplicationController

  def payables
    puts""
    puts">>>>Console Log<<<<"
    @payee_id = session[:user_id]
    payables = Contract.where("user_id=#{@payee_id}").map(&:attributes)

    @payables = []

    payables.each do |contract|
      item_id = contract['item_id']
      contract_price = contract['contract_price']
      # puts item_id
      # puts contract_price

      item = Item.find(item_id).attributes
      # puts item
      item_name = item['item_name']
      item_price = item['item_price']
      bill_id = item['bill_id']
      # puts item_name
      # puts item_price
      # puts bill_id

      bill = Bill.find(bill_id).attributes
      bill_title = bill['title']

      @payables.push({ :bill_title => bill_title, :item_name => item_name, :item_price => item_price, :contract_price => contract_price })
    end

    puts @payables


    render json: @payables
  end

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
