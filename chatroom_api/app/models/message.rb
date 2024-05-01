class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  # after_create_commit { broadcast_message }

  # private

  # def broadcast_message
  #   ActionCable.server.broadcast("chat_#{params[:recipient_id]}#{params[:user_id]}", message)
  # end
end
