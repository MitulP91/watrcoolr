class MessagesController < ApplicationController
  before_action :set_type

  def index
    @messages = type_class.all
  end

  def create
    
  end

  # Starts private functions
  private

  def set_type
    @type = type
  end

  def type
    params[:type] || "Message"
  end

  def type_class
    type.constantize
  end

  def set_message
    @message = type_class.find(params[:id])
  end
end
