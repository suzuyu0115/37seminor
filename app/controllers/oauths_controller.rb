class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        # 特定の組織にユーザーが所属しているかどうかを確認する
        organizations = request.env['omniauth.auth']['extra']['raw_info']['organizations'].map { |org| org['login'] }
        if organizations.include?('YOUR_ORGANIZATION_NAME')
          reset_session
          auto_login(@user)
          redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
        else
          redirect_to root_path, alert: 'RUNTEQに所属していないためログインできません'
        end
      rescue StandardError
        redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error)
  end
end
