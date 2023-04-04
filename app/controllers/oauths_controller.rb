class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, success: "#{provider.titleize}でログインしました。"
    else
      session[:user_info] = @user_hash[:user_info]
      redirect_to new_registration_path
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error)
  end
end
