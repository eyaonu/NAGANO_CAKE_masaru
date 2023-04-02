class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "メールアドレスを更新しました"
      redirect_to customers_path
    else
      render :edit
    end
  end

  def delete_verification
    redirect_to root_path
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy

  end

  def withdraw
    @customer = current_customer

    #is_deletedカラムをtrueに変更する
    @customer.update(is_deleted: true)

    # ログアウトさせる
    reset_session
    redirect_to root_path 
  end

  def unsubscribe
    @customer = current_customer
  end

  def delete_verification

  end

  private

  def customer_params
    params.require(:customer).permit(:email,
                                     :last_name,
                                     :last_name_kana,
                                     :first_name,
                                     :first_name_kana,
                                     :postal_code,
                                     :address,
                                     :telephone_number,
                                     :is_deleted)
  end
end