class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    # @Item.genre_id = current_genre.id
    @item.save
    redirect_to admin_item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end
end
