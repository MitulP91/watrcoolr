class MessagesController < ApplicationController
  before_action :set_type

  def index
    @messages = type_class.all
  end

  def create
    @message = Message.create(message_params)
  end

  # Parameters
  def message_params
    params.require(:message).permit(:msg_content, :self_destruct, :self_destruct_time, :self_destruct_type, :msg_type)
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
