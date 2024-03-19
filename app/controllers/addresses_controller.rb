class AddressesController < ApplicationController

  def index
    @addresses = Address.find_by(customer_id: current_customer)
    @newAddress = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_user.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.find_by(customer_id: current_customer)
      render "index"
    end
  end

  def edit
    @address = Address.get(params[:id])
  end
end
