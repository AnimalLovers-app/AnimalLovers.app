class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
<<<<<<< HEAD
    @item = Item.new
=======
    @item = Item.all
>>>>>>> origin/develop
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  private

  def item_params
<<<<<<< HEAD
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
=======
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active)
>>>>>>> origin/develop
  end
end
