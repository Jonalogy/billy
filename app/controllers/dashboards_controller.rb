class DashboardsController < ApplicationController

  def index
    puts">>>>> console.log(Dashboard#index) <<<<<"
    puts""
    puts""
    puts""
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
        puts "bill_items => #{bill_items}"
        puts "bill_items.class => #{bill_items.class}"
        @bill_items_reformat = []

          bill_items.each do |bill_item|
            puts "bill_item => #{bill_item.inspect}"
            puts""
            item = {}
            item[:id] = bill_item[:id]
            item[:bill_id] = bill_item[:bill_id]
            item[:item_name] = bill_item[:item_name]
            item[:item_price] = bill_item[:item_price]
            item[:payee_count] = Contract.where(item_id:bill_item['id'], clear:false).length
            @bill_items_reformat.push(item)

            puts "item => #{item}"
            puts "@bill_items_reformat => #{@bill_items_reformat}"

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

  private

end
