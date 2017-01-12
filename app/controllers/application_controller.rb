class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    additional_fields =[:first_name, :last_name, :profile_picture]
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_fields)
    devise_parameter_sanitizer.permit(:account_update, keys: additional_fields)
  end
  protect_from_forgery with: :exception

end
