class DashboardsController < ApplicationController

  def index
      @user_id =  session[:user_id]
      @newBill = Bill.new
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

    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end
  end

  private

end
