class DashboardsController < ApplicationController

  def index
    # puts">>>>> console.log(Dashboard#index) <<<<<"
      @user_id =  session[:user_id]
      @username = User.where(:id => @user_id).take.name
      ##puts "@username => #{@username}"
      @newBill = User.find(@user_id).bills.new

      ##puts "@newBill => #{@newBill.inspect}"

      @newItem = Item.new
      @bills = User.find(@user_id).bills.all

      # Fetch bill_ids belonging to user in array format
      @bills_all_id = User.find(@user_id).bills.all.select(:id).to_a

      # Fetching each user bill's items
      @all_bill_items = {}

      # Iterating through @bills_all_id
      @bills_all_id.each do |bill|
        bill_items = User.find(@user_id).bills.find(bill.id).items.all().to_a #Returns an array
        # puts "bill_items => #{bill_items}"
        # puts "bill_items.class => #{bill_items.class}"
        @bill_items_reformat = []

          bill_items.each do |bill_item|
            item = {}
            item[:id] = bill_item[:id]
            item[:bill_id] = bill_item[:bill_id]
            item[:item_name] = bill_item[:item_name]
            item[:item_price] = bill_item[:item_price]
            item[:payee_count] = Contract.where(item_id:bill_item['id'], clear:false).length
            @bill_items_reformat.push(item)
            # puts "item => #{item}"
            # puts "@bill_items_reformat => #{@bill_items_reformat}"
          end
        @all_bill_items[bill.id] = @bill_items_reformat

        # Contract.where(item_id:3, clear:false).length

      end

      @contract = Contract.new

    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end
  end

  def view_payees
    puts ">>>> Console.Log (Dashboard#view_payees) <<<<"
    puts view_payee_params.inspect
    puts ""
    puts ""
    puts ""
    item_id = view_payee_params[:item_id].to_i
    puts "item_id => #{item_id} #{item_id.class}"
    contracts = Contract.where(item_id: item_id, clear: false)
    puts "Contracts count == #{contracts.length}"

    @payees_all = []

    if contracts.length > 0

      contracts.each do |contract|
        puts "Inspect contract ==> #{contract.inspect} , #{contract.class}"
        if contract.user_id != nil
          puts ""
          puts ""
          puts "Finding registered payee"
          payee_id = contract.user_id
          payee = User.where(id: payee_id)
          puts "payee ==> #{payee.inspect} ,  #{payee.class}"
          @payee = {}
          @payee[:contract_id] = contract.id
          @payee[:item_id] = contract.item_id
          @payee[:payee] = payee.name
          if contract.payment_type_id != 3
            @payee[:pay_type] = PaymentType.where(id: contract.payment_type_id).take.pay_type
            @payee[:contract_amt] = contract.contract_price
          else
            @payee[:pay_type] = PaymentType.where(id: contract.payment_type_id).take.pay_type
            @payee[:favour] = Favour.where(id: contract.favour_id).take.favour_type
          end

          puts "@payee ==> #{@payee}"
          @payees_all.push(@payee)
        else
          puts ""
          puts ""
          puts "Finding non-registered payee"
          @payee = {}
          @payee[:contract_id] = contract.id
          @payee[:item_id] = contract.item_id
          @payee[:payee] = contract.payee_name
          if contract.payment_type_id != 3
            @payee[:pay_type] = PaymentType.where(id: contract.payment_type_id).take.pay_type
            @payee[:contract_amt] = contract.contract_price
          else
            @payee[:pay_type] = PaymentType.where(id: contract.payment_type_id).take.pay_type
            @payee[:favour] = Favour.where(id: contract.favour_id).take.favour_type
          end
          puts "@payee ==> #{@payee}"
          @payees_all.push(@payee)
        end
      end #contracts.each do

    else
      @payees_all = {}
    end
    puts "render json: @payees_all"
    render json: @payees_all

  end

  private

  def view_payee_params
    params.require(:data).permit(:bill_id, :item_id)
  end

end
