class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @newBill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create



    @bill = User.find(session[:user_id]).bills.new(bill_params)
    puts ">>>>Console.log<<<<"
    puts ""
    puts ""

    if params[:bill][:picture] == nil
      picture_upload = Cloudinary::Uploader.upload('https://mave.me/img/projects/full_placeholder.png')
      puts "No user image detected. picture_upload => #{picture_upload}"

      @bill[:picture] = picture_upload["url"]
    else
      picture_upload = Cloudinary::Uploader.upload(params[:bill][:picture].path,)
      puts "User picture uploaded to Cloudinary => #{picture_upload}"
      @bill[:picture] = picture_upload["url"]
    end

    puts "@bill => #{@bill.inspect}"


      save_status = @bill.save!

      if save_status

        flash[:success] = "Bill Saved!!"
        redirect_to dashboard_path
      else
        flash[:danger] = "Error encountered: Bill was not save... Please try again"
        redirect_to dashboard_path
      end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy

    puts ""
    puts ">>>Console Log<<<"
    puts "#{@bill.inspect}"
      render json: @bill
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:user_id, :title, :description, :picture, :total_price, :since, :clear )
    end
end
