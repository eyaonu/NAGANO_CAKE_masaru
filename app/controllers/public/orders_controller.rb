class Public::OrdersController < ApplicationController
  before_action :cart_item_any?, only: [:new, :confirm]

  def new
    @addresses = Address.all
    @ordered = Order.all
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item| 
      tal = cart_item.item.non_taxed_price * cart_item.amount
      @total += tal
    end
#    if session[:customer]["payment_method"] == "クレジットカード"
      @payment_method = @order.payment_method_i18n
#    elsif session[:customer]["payment_method"] == "transfer"
    if params[:order][:address_select] === "0"
#      @payment_method = "銀行振込"
    @order.postal_code = current_customer.postal_code
    @order.shipping_address = current_customer.address
    @order.direction = current_customer.fullname_display
    end
  end

  def create
  # Order.all.destroy_all
  order = Order.new(order_params)
  order.postage = 300
  order.save
  cart_items = order.customer.cart_items
  cart_items.each do |cart_item|

  order_detail = OrderDetail.new

  order_detail.order_id = order.id
  order_detail.item_id = cart_item.item.id
  order_detail.unit_price = cart_item.item.non_taxed_price
  order_detail.quantity = cart_item.amount
  order_detail.save
  end


  cart_items.destroy_all

    #支払い方法のセッション情報
    # if params[:payment_select] == "0"
    #   session[:customer][:payment_method] = 0
    # elsif params[:payment_select] == "1"
    #   session[:customer][:payment_method] = 1
    # end

    # #配送先登録のセッション情報
    # if params[:address_select] == "0"
    #   session[:customer][:postal_code] = current_customer.postal_code
    #   session[:customer][:shipping_address] = current_customer.address
    #   session[:customer][:direction] = current_customer.full_name
    # elsif params[:address_select] == "1"
    #   session[:customer][:postal_code] =  Address.find(params[:address_id]).postal_code
    #   session[:customer][:shipping_address] = Address.find(params[:address_id]).address
    #   session[:customer][:direction] = Address.find(params[:address_id]).direction
    # else 
    #   session[:customer][:postal_code] =  params[:postal_code]
    #   session[:customer][:shipping_address] = params[:shipping_address]
    #   session[:customer][:direction] = params[:direction]
    # end
    redirect_to orders_complete_path
    
  end

  def complete
    # order = Order.new(session[:customer])
    # order.postage = 0
    # order.payment = 0
    # order.status = 1
    # order.customer_id = current_customer.id
    # order.save
    # cart_items = current_customer.cart_items
    # cart_items.each do |cart_item|
    #   ordered_item = OrderDetail.new
    #   ordered_item.item_id = cart_item.item.id
    #   ordered_item.production_status = 0
    #   ordered_item.unit_price = cart_item.item.non_taxed_price
    #   ordered_item.quantity = cart_item.amount
    #   ordered_item.order_id = order.id
    #   ordered_item.save
    # end
    # cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:direction,:customer_id,:postage,:payment,
                                  :postal_code,
                                  :shipping_address,
                                  :payment_method)
  end

  def cart_item_any?
    if current_customer.cart_items.empty?
      redirect_to customers_path
    end
  end
end