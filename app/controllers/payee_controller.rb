class PayeeController < ApplicationController

  def payables
    @payables_data = []

    @payee = User.find(session[:user_id])
    puts""
    puts">>>>Console Log<<<<"
    all_payables = @payee.payables

    puts "all_payables => #{all_payables.inspect} \n Length = #{all_payables.length} "

    all_payables.each do |bill|
      @payCard = {}
      @payCard[:bill] = bill.attributes

      items_found = Bill.find(bill.id).items_for_payee(session[:user_id]).map(&:attributes)
      puts "items_found => #{items_found} \n length = #{items_found.length}"

      items = []

      items_found.each do |item|
        item_id = item['id']
        contract = Contract.where(:item_id => item_id, :user_id => session[:user_id])[0]
        # puts "contract => #{contract.inspect} \n length = #{contract.length}"
        item["contract_id"] = contract.id
        item["contract_price"] = contract.contract_price
        item["contract_payType"] = PaymentType.find(contract.payment_type_id).pay_type
        item["contract_payType_id"] = contract.payment_type_id
        puts "item['contract_payType_id'] => #{item['contract_payType_id']}"

        if item["contract_payType_id"] == 3
          item["favour_description"] = Favour.where(:id => contract.favour_id).take.favour_type
          puts "item['favour_description'] => #{item['favour_description']}"
        end

        items.push(item)
      end
      @payCard["items"] = items

      @payables_data.push(@payCard)

      puts "@payables_data => #{@payables_data}"
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
