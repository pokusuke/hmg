class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
    #ActionCable.server.broadcast 'chat_channel',message: 'connected.'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast "chat_#{params[:room]}",message: data['message']
  end
end
