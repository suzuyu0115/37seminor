class JoinsController < ApplicationController
  def create
		quest = Quest.find(params[:quest_id])
		current_user.join(quest)
		redirect_back fallback_location: root_path
	end

	def destroy
		quest = current_user.joins.find(params[:id]).quest
		current_user.unjoin(quest)
		redirect_back fallback_location: root_path
	end

  # 参加したクエスト一覧を表示するアクション
  def joins
    @join_quests = current_user.join_quests.includes(:user).order(created_at: :desc)
  end
end
