class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      #flash[:success] = "メールアドレスを更新しました"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  def page

  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :genre_id, :non_taxed_price, :sales_status, :description, :introduction)
  end
end