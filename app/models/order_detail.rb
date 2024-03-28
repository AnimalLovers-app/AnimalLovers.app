class OrderDetail < ApplicationRecord
  belongs_to :order, optional:true
  belongs_to :item, optional:true

  enum making_status: { not_allowed: 0, allowed: 1, in_process: 2, finished: 3 }

  def subtotal
    price * amount
  end
end
