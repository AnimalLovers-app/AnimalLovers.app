class Public::CustomersController < ApplicationController
  before_action :is_matching_login_user, only: [:withdrow, :update]

 def show
    @customer = current_customer
    @addresses = current_customer.address
 end

  def edit
    @customer = current_customer
  end

  def update
   @customer = current_customer
     if @customer.update(customer_params)
      redirect_to customers_mypage_path
     else
      render :edit
     end
  end


#退会機能
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    #トップ顔面のurlができたら変更する!!
    redirect_to root_path
  end

private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end