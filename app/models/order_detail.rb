class OrderDetail < ApplicationRecord
  belongs_to :order, optional:true
end
