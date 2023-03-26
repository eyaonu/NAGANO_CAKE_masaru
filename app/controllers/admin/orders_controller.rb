class Admin::OrdersController < ApplicationController
  def update
    order = Order.find(params[:id])
    #注文ステータスが"入金確認"になったら製作ステータスを"製作待ち"
    if params[:order][:status] == "b"
      order.order_items.each do |order_item|
        order_item.production_status = "b"
        order_item.update(production_status: order_item.production_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path(order)
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_item = @order.order_items
    #商品合計
    @total = 0
    @order_item.each do |order_item|
      tol = order_item.item.non_taxed_price * order_item.quantity
      @total += tol 
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end