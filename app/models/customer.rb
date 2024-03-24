class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items
  has_many :orders
  #姓と名を合わせて表示する
  def full_name
    family_name + '' + first_name
  end

  def full_name_kana
    family_name_kana + '' + first_name_kana
  end


  def active_for_authentication?
    super && (is_active == true)
  end

end
