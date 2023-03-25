class QuestsController < ApplicationController
  before_action :set_quest, only: %i[edit update]

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
      render :new
    end
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def edit; end

  def update
    if @quest.update(quest_params)
      redirect_to @quest
    else
      render :edit
    end
  end

  private

  def set_quest
    @quest = current_user.quests.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :body, :step, :date_time, :place)
  end
end
