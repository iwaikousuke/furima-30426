class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tweet, only:[:show,:edit,:update]
  before_action :move_to_index, only:[:edit]
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :status_id, :shopping_id, :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
  end

  def set_tweet
    @item = Item.find(params[:id])
  end

  def move_to_index
    if current_user.id != @item.user.id || @item.purchase.present?
      redirect_to root_path
    end
  end
end
