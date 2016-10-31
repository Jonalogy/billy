class DashboardsController < ApplicationController

  def index
      @user =  session[:user_id]
      @newBill = Bill.new
      @bills = Bill.all

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
