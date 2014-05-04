class HomeController < ApplicationController
  def index
    @rooms = Room.all
    @all_tribunals = Tribunal.all
    @user = current_user
    @current_user_rooms = current_user.rooms
    @tribunals = current_user.tribunals
    @current_user_tribunals = []

    current_user.tribunals.each do |a|

    	trib_info = []
    	room = Room.find(a.room_id)
    	trib_info << a
    	trib_info << room.name
    	# trib_info << room.users
    	@current_user_tribunals << trib_info
    end
  end

  def landing
  	render :layout 	=> false
  end
end
