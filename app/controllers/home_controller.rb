class HomeController < ApplicationController
  def index
    @rooms = Room.all
    @user = current_user
  end

  def landing
  	render :layout 	=> false
  end
end
