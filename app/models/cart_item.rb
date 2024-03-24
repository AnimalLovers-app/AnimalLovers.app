class CartItem < ApplicationRecord
  belongs_to :customer, optional:true
  belongs_to :item, optional:true

  def subtotal
    item.with_tax_price * amount
  end

end
