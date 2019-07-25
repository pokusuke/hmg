class MsgChannel < ApplicationCable::Channel
  def subscribed
     stream_from "msg_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast('msg_channel',data)
  end
end
