class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :email, :postal_code, :prefecture_code, :address_street, :address_city, :address_building])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:name])
  end
end
