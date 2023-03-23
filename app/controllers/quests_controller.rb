class QuestsController < ApplicationController
  def index
    @quests = Quest.all.includes(:user).order(created_at: :desc)
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = current_user.quests.build(quest_params)
    if @quest.save
      redirect_to quests_path, success: 'クエストを作成しました'
    else
      flash.now['danger'] = 'クエストの作成に失敗しました'
      render :new
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :body, :step, :date_time, :place)
  end
end
