# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!, only: [:edit]

  def new
    super
  end

  def create
    super
  end

  def edit
    super
    @user = User.find(current_user.id)

  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    @user.s_diving = Date.new(params[:user]["s_diving(1i)"].to_i, params[:user]["s_diving(2i)"].to_i).strftime("%Y-%m")
    bypass_sign_in(@user)
    redirect_to show_user_path(@user.id)
  end

  def show
    @user = User.find(params[:id])
    @user_logs = @user.logs.all
    if Date.today.month > @user.s_diving.month
      @yearsOfExperience = "#{Date.today.year - @user.s_diving.year} 年 #{Date.today.month - @user.s_diving.month} ヶ月"
    else
      @yearsOfExperience = "#{Date.today.year - @user.s_diving.year - 1} 年 #{12 + Date.today.month - @user.s_diving.month} ヶ月"
    end
  end

  def years_of_experience
    returne "#{Date.today.year - @user.s_diving.year} 年 #{Date.today.month - @user.s_diving.month}ヶ月"
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :photo, :self_introduction, :s_diving, :license, :prefecture_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :photo, :self_introduction, :s_diving, :license, :prefecture_id])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for()
    '/logs/index'
    # super(resource)
  end

  def user_params
    params.require(:user).permit(:photo, :nickname, :email, :self_introduction, :s_diving, :prefecture_id, :password)
  end
end
