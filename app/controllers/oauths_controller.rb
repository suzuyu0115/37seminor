class OauthsController < ApplicationController
  #before_action :secret_word, only: %i[login]
  skip_before_action :require_login, only: %i[oauth callback login]

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to quests_path, success: t('.success')
    else
      begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to quests_path, success: t('.success')
      rescue
        redirect_to root_path, danger: t('.fail')
      end
    end
  end

  def secret_word
    if valid_password?
      redirect_to login_path
    end
  end

  def login; end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end

  def valid_password?
    params[:secret_word] == ENV['SECRET_WORD']
  end
end
