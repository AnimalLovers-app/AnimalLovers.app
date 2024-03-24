class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @customers = Customer.all
    @orders = Order.page(params[:page]).per(10)
    @total_amount = 0
  end
end
