class MessagesSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :recipient_id, :chatroom_id
end
