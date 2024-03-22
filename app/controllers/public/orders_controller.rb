class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_member.cart_items.all
    @total = 0

    # [:address_option]=="0"の場合、current_customerの住所を呼び出す
    if params[:order][:address_option] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name

    # [:address_option]=="1"の場合、プルダウンで選択された値から呼び出す
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name

    # [:address_option]=="2"の場合、formに入力されたデータを受け取る
    elsif params[:order][:address_option] = "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

    else
      render 'new'
    end
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id =  @order.id
      @order_details.item_id = cart_item.item_id
      @order_details.amount = cart_item.amount
      @order_details.price = cart_item.subtotal
      @order_details.save
    end

    current_member.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
  end

  def show
  end

  private
    def order_params
        params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

end
