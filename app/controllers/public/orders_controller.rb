class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800
    @total = 0

    # [:address_option]=="0"の場合、current_customerの住所を呼び出す
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name

    # [:address_option]=="1"の場合、プルダウンで選択された値から呼び出す
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    # [:address_option]=="2"の場合、formに入力されたデータを受け取る
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

    else
      render 'new'
    end

    if @order.postal_code.blank?||@order.address.blank?||@order.name.blank?||@order.payment_method.blank?
      redirect_to new_order_path, notice: "設定されていない項目があります"
    end
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @total = 0
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id =  @order.id
      @order_details.item_id = cart_item.item_id
      @order_details.amount = cart_item.amount
      @order_details.price = cart_item.subtotal
      @order_details.save
      @total += cart_item.item.with_tax_price * cart_item.amount
    end

    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def index
    @orders = Order.all
    @cart_items = current_customer.cart_items.all
    @total=0
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @cart_items = current_customer.cart_items.all
    @total=0
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

end
