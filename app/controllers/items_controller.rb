class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    user = session[:user_id]
    @items = User.find(user).bills.find( id ).items.all
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    user = session[:user_id]
    @item = User.find(user).bills.find(params[:item][:bill_id]).items.new(item_params)
    @bill_id = params[:item][:bill_id]

    # respond_to do |format|
      if @item.save
        # puts ">>>New Item Saved<<<"
        # redirect_to item_path(:item => @item, :bill_id => @bill_id)
        # format.html
        # format.json {
          render json: @item, status: :created
        # }
      else
          puts ">>>Error: New item was not saved!<<<"
        # format.html { render :new }
        # format.json {
          render json: @item.errors, status: :unprocessable_entity
        # }
      end
    # end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:bill_id, :item_name, :item_price)
    end
end
