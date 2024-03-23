class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_item_path(item.id)
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end
end
