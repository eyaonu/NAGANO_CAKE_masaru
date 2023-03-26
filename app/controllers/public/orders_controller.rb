class Public::OrdersController < ApplicationController
  before_action :cart_item_any?, only: [:new, :confirm]

  def new
    @addresses = Address.all
    @ordered = Order.all
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item| 
      tal = cart_item.item.non_taxed_price * cart_item.amount
      @total += tal
    end
#    if session[:customer]["payment_method"] == "credit_card"
      @payment_method = "クレジット払い"
#    elsif session[:customer]["payment_method"] == "bunk"
#      @payment_method = "現金払い"
    
  end

  def create
#    session:customer = Order.new()

    #支払い方法のセッション情報
    if params[:payment_select] == "0"
      session[:customer][:payment_method] = 0
    elsif params[:payment_select] == "1"
      session[:customer][:payment_method] = 1
    end
    
    #配送先登録のセッション情報
    if params[:address_select] == "0"
      session[:customer][:postal_code] = current_customer.postal_code
      session[:customer][:shipping_address] = current_customer.address
      session[:customer][:direction] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:customer][:postal_code] =  Address.find(params[:address_id]).postal_code
      session[:customer][:shipping_address] = Address.find(params[:address_id]).address
      session[:customer][:direction] = Address.find(params[:address_id]).direction
    else 
      session[:customer][:postal_code] =  params[:postal_code]
      session[:customer][:shipping_address] = params[:shipping_address]
      session[:customer][:direction] = params[:direction]
    end
    redirect_to orders_complete_path
    
  end

  def complete
    order = Order.new(session[:customer])
    order.postage = 500
    order.payment = 1000
    order.status = 1
    order.customer_id = current_customer.id
    order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      ordered_item = OrderDetail.new
      ordered_item.item_id = cart_item.item.id
      ordered_item.production_status = 0
      ordered_item.unit_price = cart_item.item.non_taxed_price
      ordered_item.quantity = cart_item.amount
      ordered_item.order_id = order.id
      ordered_item.save
    end
    cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:direction, 
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