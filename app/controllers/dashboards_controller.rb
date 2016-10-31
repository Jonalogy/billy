class DashboardsController < ApplicationController

  def index
      @user_id =  session[:user_id]
      @newBill = Bill.new
      @bills = User.find(@user_id).bills.all
      puts ">>> Start Logging <<<"
      puts ""
      puts "@bills >>> #{@bills.inspect}"
      puts ""
      puts ">>> End Logging <<<"

    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end

    # render json: @bills
  end

  private

    def bill_params
      params.require(:bill).permit
    end

    # def person_params
    #   params.require(:person).permit(:name, :age)
    # end

end
