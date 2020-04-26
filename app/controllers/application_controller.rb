class ApplicationController < ActionController::Base
  require 'date' 
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :authenticate_user!, expect: :index
  protect_from_forgery with: :exception

  protected
  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :photo, :selt_introduction, :license, :address])
  end
end
