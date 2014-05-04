require 'streamer/sse' # found in lib

class RoomsController < ApplicationController
  include ActionController::Live  # allows for use of SSE and concurrency (web socket)

  def watrcoolr
    @room = Room.find(params[:id])
    @user_id = current_user.id.to_i
    @messages = Message.where(room_id: @room.id)
    @text_message = Message.new
  end

  def add_message
    response.headers['Content-Type'] = 'text/javascript' # Tells Rails/Redis that content is JavaScript
    # @message = Message.create(message_params)
    # message = @message.msg_content
    message = params[:msg_content]
    # room = @message.room_id
    room = params[:room]
    # -- Add new message to chatroom ---
    $redis.publish("add_message_#{room}", {message: message, author: current_user.username, room: room}.to_json)
    # --- end ---

    render :nothing => true, :status => 200
  end

  def message_params
    params.permit(:self_destruct, :self_destruct_time, :self_destruct_type, :msg_type, :room_id, :user_id, :msg_content)
  end















  # Controls all redis subscriptions to each room ----------------------------------------
  def events
    response.headers['Content-Type'] = 'text/event-stream' # Starts a Redis event stream (thread)
    room_id = params[:room_id]
    sse = Streamer::SSE.new(response.stream) # Opens server sent event stream
    redis ||= Redis.new # If the user doesn't already have a thread open, creates a new redis thread
    # --- Adds all the subscription events for each room --- 
    redis.subscribe(["add_message_#{room_id}", "heart"]) do |on|
      on.message do |event, data|
        if event == "add_message_#{room_id}" # For the add song subscription
          sse.write(data, event: "add_message_#{room_id}")
        end
      end
    end
    # --- end ---
  rescue IOError
    # Client disconnected
    redis.quit
    sse.close
    response.stream.close
  ensure
    # When not being used, threads close
    redis.quit
    sse.close
    response.stream.close
  end
end
