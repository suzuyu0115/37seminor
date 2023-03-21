class QuestsController < ApplicationController
  def index
    @quests = Quest.all.includes(:user).order(created_at: :desc)
  end
end
