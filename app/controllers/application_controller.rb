class ApplicationController < ActionController::Base
 #  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
          admin_orders_path
    else
          root_path # ログイン後に遷移するpathを設定
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :public
      root_path # ログアウト後に遷移するpathを設定
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys:)
  # end
  end
end