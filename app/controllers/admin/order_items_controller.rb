class Admin::OrderItemsController < ApplicationController

  def update
  order_item = OrderItem.find(params[:order_item][:order_item_id])
  order = order_item.order

  #注文商品の製作ステータスが1つでも“製作中“で注文ステータスを“製作中“に更新
  if params[:order_item][:production_status] == "c"
  order.update(status: "c")
  end
  order_item.update(production_status: params[:order_item][:production_status])

  #注文商品全ての製作ステータスが“製作完了“で注文ステータスを“発送準備中“に
  status = 0
  order = Order.find(params[:id])
  order.order_items.each do |order_item| 
  if order_item.production_status != "d"
    status = 1
  end
end
        if status == 0
          order.update(status: "d")
        end
        redirect_to admin_orders_path
  end
end