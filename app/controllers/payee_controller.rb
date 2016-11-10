class PayeeController < ApplicationController

  def payables
    @payables_data = []

    @payee = User.find(session[:user_id])
    all_payables = @payee.payables

    all_payables.each do |bill|
      # puts""
      # puts">>>>Console Log<<<<"
      @payCard = {}
      @payCard[:bill] = bill.attributes

      items_found = Bill.find(bill.id).items_for_payee(session[:user_id]).map(&:attributes)

      items = []

      items_found.each do |item|
        item_id = item['id']

        contract = Contract.where(:item_id => item_id)[0]
        item["contract_id"] = contract.id
        item["contract_price"] = contract.contract_price
        item["contract_payType"] = PaymentType.find(contract.payment_type_id).pay_type

        if Favour.where(:contract_id => contract.id).exists?
          item["favour_description"] = Favour.where(:contract_id => contract.id)[0].description
        end

        items.push(item)
      end
      @payCard["items"] = items

      @payables_data.push(@payCard)
    end

    render json: @payables_data
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
