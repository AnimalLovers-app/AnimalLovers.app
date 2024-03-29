class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:update, :destroy]
  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'カート内の商品の数量を更新しました'
    else
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: 'カート内の商品を削除しました。'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カート内の商品を全て削除しました'
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

  def is_matching_login_customer
    cart_item = CartItem.find(params[:id])
    unless cart_item.customer_id == current_customer.id
      redirect_to root_path
    end
  end
end

