class TribunalsController < ApplicationController
	def index
		@tribunals = current_user.tribunals
	end

	def create
		@tribunal = Tribunal.create(tribunal_params)
		@room = Room.find(@tribunal.room_id)
		@room.users.each do |user|
			user.tribunals << @tribunal
		end
		render :nothing => true
	end

	def vote
		@tribunal = Tribunal.find(params[:tribunal_id])
		if params[:vote_type] == 'for'
			@tribunal.votes_for += 1
		else 
			@tribunal.votes_against += 1
		end
		Tribunal.update(@tribunal)
	end


	def tribunal_params
		params.permit(:room_id, :user_id, :votes_for, :votes_against, :active)
	end

	private

end