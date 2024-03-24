class Address < ApplicationRecord

  belongs_to :customer

<<<<<<< HEAD
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
=======
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
>>>>>>> origin/develop

end
