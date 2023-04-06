require 'octokit'
class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    client = Octokit::Client.new(access_token: ENV['GITHUB_SECRET'], scopes: 'user:email, read:org')
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
