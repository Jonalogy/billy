class DashboardsController < ApplicationController

  def index
      @user_id =  session[:user_id]
      @newBill = Bill.new
      @bills = User.find(@user_id).bills.all

      # Fetch bill_ids in array format
      @bills_all_id = User.find(@user_id).bills.all.select(:id).to_a

      # Fetching each user bill's items
      @all_bill_items = {}
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

    def bill_params
      params.require(:bill).permit
    end

    # def person_params
    #   params.require(:person).permit(:name, :age)
    # end

end
