class AddressesController < ApplicationController

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.find_by(customer_id: current_customer)
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
    unless @address.customer_id == current_customer.id
      redirect_to addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end


  private

  def address_params
  params.require(:address).permit(:postal_code, :address, :name)
  end

end
