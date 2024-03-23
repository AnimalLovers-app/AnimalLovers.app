class Public::ItemsController < ApplicationController
  def index
    @item_all = Item.all
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item_all = Item.all
    @items = Item.page(params[:page]).per(8)
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
