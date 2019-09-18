class MsgChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "msg_channel_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # ActionCable.server.broadcast "chat_#{params[:room]}",message: data['message']

    Msg.create!(
      sender_id: current_user.id,
      reciever_id: params[:rec],
      msg: data['message']['msg'],
      photo_url_data_uri: data['message']['pic']
    )
    data['message']['sender_name'] = current_user.name
    ActionCable.server.broadcast "msg_channel_#{params[:room]}", message: data['message']
  end
end
