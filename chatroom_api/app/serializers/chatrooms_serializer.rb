class ChatroomsSerializer < ActiveModel::Serializer
  attributes :id, :title, :sender_id, :messages
end
