class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      #binding.pry
      redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
        # 特定の組織にユーザーが所属しているかどうかを確認する
        #binding.pry
        organizations = request.env['omniauth.auth']['extra']['raw_info']['organizations']&.map { |org| org['login'] }
        binding.pry
        #if organizations.include?('RUNTEQ')
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to quests_path, notice: "#{provider.titleize}でログインしました"
        # else
        #   redirect_to root_path, alert: 'RUNTEQに所属していないためログインできません'
        # end
      rescue StandardError
        redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました"
      end
    end
  end

  # private

  # def auth_params
  #   params.permit(:code, :provider, :error)
  # end

  # def create_from(provider)
  #   if provider == 'github'
  #     user_info = request.env['omniauth.auth']['info']
  #     organizations = request.env['omniauth.auth']['extra']['raw_info']['organizations']
  #     if organizations && organizations.map { |org| org['login'] }.include?('RUNTEQ')
  #       User.create(name: user_info['name'], email: user_info['email'], password: SecureRandom.hex)
  #     else
  #       raise "You don't belong to RUNTEQ"
  #     end
  #   else
  #     raise NotImplementedError, "Provider #{provider} not implemented."
  #   end
  # end
end
