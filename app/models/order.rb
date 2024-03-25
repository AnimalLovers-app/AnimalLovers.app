class Order < ApplicationRecord
  has_many :order_details
  has_many :items, through: :order_details
  belongs_to :customer, optional:true

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_payment: 0, payment_confirmed: 1, in_making: 2, shipment_preparation: 3, completed: 4 }

  #注文履歴一覧でamountのトータルを計算するメソッド
  def sum_of_amount
    order_details.sum(:amount)
  end

end
