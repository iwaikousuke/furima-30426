class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, expect: [:index, :create]
  
  def index
    @item = Item.find(params[:item_id])
    @order_purchase = OrderPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_purchase = OrderPurchase.new(purchase_params)

    if @order_purchase.valid?
      pay_item
      @order_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  
  def purchase_params
  params.require(:order_purchase).permit(:postal_code, :prefecture_id, :city, :street_address, :phone_number, :building, :item_id).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
 end

  def pay_item
    Payjp.api_key =  ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
       currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    elsif current_user.id != @item.user_id
      redirect_to root_path
    end

  end
end