class DashboardsController < ApplicationController

  def index
    puts ""
    puts ""
    puts">>>>> console.log <<<<<"
      @user_id =  session[:user_id]
      @username = User.where(:id => @user_id).take.name
      #puts "@username => #{@username}"
      @newBill = User.find(@user_id).bills.new

      #puts "@newBill => #{@newBill.inspect}"

      @newItem = Item.new
      @bills = User.find(@user_id).bills.all

      # Fetch bill_ids belonging to user in array format
      @bills_all_id = User.find(@user_id).bills.all.select(:id).to_a

      # Fetching each user bill's items
      @all_bill_items = {}

      # Iterating through @bills_all_id
      @bills_all_id.each do |bill|
        @bill_items = User.find(@user_id).bills.find(bill.id).items.all() #Returns an array
        @all_bill_items[bill.id] = @bill_items
      end

      @contract = Contract.new

    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end
  end

  private

end
