class MsgBroadCastJob < ApplicationJob
  queue_as :default

  def perform(_message)
    # Do something later
    ActionCable.server.broadcast ''
  end
end
