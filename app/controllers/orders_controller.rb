class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_tweet, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  

  def index
    @order_purchase = OrderPurchase.new
  end

  def create
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


  def set_tweet
    @item = Item.find(params[:item_id])
  end


  def move_to_index
    if current_user.id == @item.user.id   #一行で収めたい場合は｜｜を使用　elsif文は不要。
      redirect_to root_path
    elsif @item.purchase.present?
      redirect_to root_path
    end
  end
end
