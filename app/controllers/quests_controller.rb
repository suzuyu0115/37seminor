class QuestsController < ApplicationController
  before_action :set_quest, only: %i[edit update]

  def index
    @quests = Quest.all.includes(:user).order(created_at: :desc)
  end

  def new
    @quest = Quest.new
    render layout: "quest_layout"
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
    @joins = Join.where(quest_id: @quest.id)
  end

  def edit
    render layout: "quest_layout"
  end

  def update
    if @quest.update(quest_params)
      redirect_to @quest
    else
      render :edit
    end
  end

  # 参加したクエスト一覧を表示するアクション
  def joins
    @join_quests = current_user.join_quests.includes(:user).order(created_at: :desc)
  end

  # クエストの未討伐/討伐完了を切り替えるアクション
  def toggle_state
    @quest = Quest.find(params[:id])
    @quest.completed! if @quest.not_completed?
    redirect_to quests_path
  end

  private

  def set_quest
    @quest = current_user.quests.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :body, :step, :date_time, :place)
  end
end
