class FavoursController < ApplicationController
  before_action :set_favour, only: [:show, :edit, :update, :destroy]

  # GET /favours
  # GET /favours.json
  def index
    @favours = Favour.all
  end

  # GET /favours/1
  # GET /favours/1.json
  def show
  end

  # GET /favours/new
  def new
    @favour = Favour.new
  end

  # GET /favours/1/edit
  def edit
  end

  # POST /favours
  # POST /favours.json
  def create
    @favour = Favour.new(favour_params)

    respond_to do |format|
      if @favour.save
        format.html { redirect_to @favour, notice: 'Favour was successfully created.' }
        format.json { render :show, status: :created, location: @favour }
      else
        format.html { render :new }
        format.json { render json: @favour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favours/1
  # PATCH/PUT /favours/1.json
  def update
    respond_to do |format|
      if @favour.update(favour_params)
        format.html { redirect_to @favour, notice: 'Favour was successfully updated.' }
        format.json { render :show, status: :ok, location: @favour }
      else
        format.html { render :edit }
        format.json { render json: @favour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favours/1
  # DELETE /favours/1.json
  def destroy
    @favour.destroy
    respond_to do |format|
      format.html { redirect_to favours_url, notice: 'Favour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favour
      @favour = Favour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favour_params
      params.require(:favour).permit(:contract_id, :description, :owner_agree, :payee-agree)
    end
end
