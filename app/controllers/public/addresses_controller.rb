class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]

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
      @addresses = current_customer.addresses
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
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end


  private
  #ストロングパラメータ
  def address_params
  params.require(:address).permit(:postal_code, :address, :name)
  end
  #アクセス制限
  def is_matching_login_customer
    address = Address.find(params[:id])
    unless address.customer_id == current_customer.id
      redirect_to new_customer_session_path
    end
  end

end
