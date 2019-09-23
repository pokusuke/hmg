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
    if current_user.avatar_path?
     data['message']['sender_pic'] = current_user.avatar_path.url
    else
     data['message']['sender_pic'] = asset_path("no-image-human.png")
    end
    ActionCable.server.broadcast "msg_channel_#{params[:room]}", message: data['message']
  end
end
