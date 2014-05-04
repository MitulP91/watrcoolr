class TribunalsController < ApplicationController
	def index
		@tribunals = current_user.tribunals
	end

	def create
		@tribunal = Tribunal.create(tribunal_params)
		render :nothing => true
	end

	def vote_for
		@tribunal = Tribunal.find(params[:user_id])
		@tribunal.votes_for += 1
		Tribunal.update(@tribunal)
	end

	def vote_against
		@tribunal = Tribunal.find(params[:user_id])
		@tribunal.votes_against += 1
		Tribunal.update(@tribunal)
	end


	def tribunal_params
		params.permit(:room_id, :user_id, :votes_for, :votes_against, :active)
	end

	private

end