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
      redirect_to quests_path, success: t('defaults.message.created', item: Quest.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Quest.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @quest = Quest.find(params[:id])
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :body, :step, :date_time, :place)
  end
end
