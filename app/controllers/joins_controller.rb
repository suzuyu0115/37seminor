class JoinsController < ApplicationController
  def create
		quest = Quest.find(params[:quest_id])
		current_user.join(quest)
		redirect_back fallback_location: quest
	end

	def destroy
		quest = current_user.joins.find(params[:id]).quest
		current_user.unjoin(quest)
		redirect_back fallback_location: quest
	end
end
