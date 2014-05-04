require 'streamer/sse' # found in lib

class MessagesController < ApplicationController
  include ActionController::Live  # allows for use of SSE and concurrency (web socket)

  def index
    @messages = type_class.all
  end

  def create
    @message = Message.create(message_params)

    if(@message.self_destruct == true) 
      # response.headers['Content-Type'] = 'text/javascript' # Tells Rails/Redis that content is JavaScript
      sleep(@message.self_destruct_time)
      @message.destroy;
      $redis.publish("remove_message_#{room}", {message_id: @message.id}.to_json)
    end
    render :nothing => true
  end

  # Parameters
  def message_params
    params.permit(:self_destruct, :self_destruct_time, :self_destruct_type, :msg_type, :room_id, :user_id, :msg_content)
  end
end
