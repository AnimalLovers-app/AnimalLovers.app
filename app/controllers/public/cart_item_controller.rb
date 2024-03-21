class Public::CartItemController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def remove_all
    CartItem.destroy_all
    redirect_to  cart_items_path, notice: 'カート内の商品を全て削除しました'
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
