class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "chat_#{params[:sender_id]}#{params[:recipient_id]}"
  end

  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end
end
