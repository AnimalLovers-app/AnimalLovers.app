class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items
  belongs_to :genre, optional:true
  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end

