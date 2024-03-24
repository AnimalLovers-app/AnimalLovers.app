class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_cade,presence: true
  validates :address,presence: true
  validates :name,presence: true

end
