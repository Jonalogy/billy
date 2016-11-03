class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    if params[:contract_reg].present? && params[:contract_reg][:reg_user] == 'true'

      @contract = Contract.new(reg_user_params)
      puts @contract.inspect
      save_status = @contract.save

      if save_status
        render json: @contract
      end


    elsif noreg_user_verify_params[:reg_user] == 'false'
      puts " "
      puts ">>>>>>>>>>Console.log<<<<<<<<<<<"
        @contract = Contract.new(non_reg_user_params)

        payee_name = non_reg_user_params[:payee_name]
        owner = User.where(id: session[:user_id]).take.name
        contract_price = non_reg_user_params[:contract_price].to_s
        item = Item.where(id: non_reg_user_params[:item_id]).take.item_name

        save_status = @contract.save
        puts save_status
        if save_status
          puts "Twilio: Attempting to send SMS"
          recipient_no = ENV["twilio_recipient_no"]
          sms(recipient_no, "Hi " + payee_name + "!\n" + owner + " has agreed to share the cost of " + item + " with you. You\'re to contribute: $" + contract_price + ".\n~Sent from Billy App " )
          render json: @contract
        else
          render json: @contract.errors
        end

    end #if params[:contract_noreg][:reg_user]

  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:user_id, :item_id, :contract_price, :payment_type_id, :favour_id, :clear)
    end

    def noreg_user_verify_params
      params.require(:contract_noreg).permit(:reg_user)
    end
    def non_reg_user_params
      params.require(:contract_noreg).permit(:item_id,:payee_name, :payee_contact, :contract_price, :payment_type_id)
    end
    def reg_user_verify_params
      params.require(:contract_reg).permit(:reg_user)
    end
    def reg_user_params
      params.require(:contract_reg).permit(:item_id, :user_id, :contract_price, :payment_type_id)
    end
end
