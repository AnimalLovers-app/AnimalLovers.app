class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :admin
  
  def get_item_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [100, 100]).processed
  end
end

