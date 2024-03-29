class Public::ItemsController < ApplicationController
  def index
    @item_on_sale = Item.where(is_active: true)
    @items = @item_on_sale.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    if @item.is_active == false
      redirect_to items_path
    end
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end