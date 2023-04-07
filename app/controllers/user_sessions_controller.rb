class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
