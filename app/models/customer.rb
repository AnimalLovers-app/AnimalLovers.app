class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #姓と名を合わせて表示する
  def full_name
    family_name + '' + first_name
  end

  def full_name_kana
    family_name_kana + '' + first_name_kana
  end

end
