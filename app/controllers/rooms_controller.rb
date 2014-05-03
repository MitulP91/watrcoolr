require 'streamer/sse' # found in lib

class RoomsController < ApplicationController
  include ActionController::Live  # allows for use of SSE and concurrency (web socket)

  def watrcoolr
    @room = Room.find(params[:id]);
    @text_message = Message.new
  end

  def add_message
    response.headers['Content-Type'] = 'text/javascript' # Tells Rails/Redis that content is JavaScript
    room = current_user.room
    message = params[:message]
    # -- Add new message to chatroom ---
    $redis.publish("add_message_#{room.id}", {message: message, author: current_user.email}.to_json)
    # --- end ---
    render nothing: true
  end

  # Parameters
  def message_params
    params.require(:message).permit(:msg_content, :self_destruct, :self_destruct_time, :self_destruct_type, :type)
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
        elsif event == "heart" # For the heartbeat subscription
          sse.write(data, event: "heart")
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
