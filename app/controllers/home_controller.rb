class HomeController < ApplicationController
  def index
    @rooms = Room.all
    @user = current_user
    @current_user_rooms = current_user.rooms
  end

  def landing
  	render :layout 	=> false
  end
end
